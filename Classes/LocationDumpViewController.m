//
//  LocationDumpViewController.m
//  LocationDump
//
//  Created by Mikhail Kalugin on 12/23/09.
//  Copyright Mikhail Kalugin 2009. All rights reserved.
//

#import "LocationDumpViewController.h"
#import "HeavyOperation.h"
#import "JSON.h"

@implementation LocationDumpViewController


- (void)logMessage:(NSString*)message {
	NSDate * now = [NSDate date];
	NSLog(@"%@: %@", now, message);
	_textView.text = [_textView.text stringByAppendingFormat:@"\n%@: %@", now, message]; 
	[_textView scrollRangeToVisible:NSMakeRange([_textView.text length] - 1, 1)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	_operationQueue = [[NSOperationQueue alloc] init];
	_locationManager = [[CLLocationManager alloc] init];
	_locationManager.delegate = self;
	_textView.text = @"";
}

- (IBAction)startUpdating {
	if (_startTime == nil) {
		_startTime = [[NSDate date] retain];
		_updates = [[NSMutableArray arrayWithCapacity:500] retain];		
	}
		
	[_locationManager startUpdatingLocation];
	[self logMessage:[NSString stringWithFormat:@"startUpdating"]];
}

- (IBAction)stopUpdating {
	[_startTime release];
	_startTime = nil;
	[_updates release];
	_updates = nil;
	[_locationManager stopUpdatingLocation];
	[self logMessage:[NSString stringWithFormat:@"stopUpdating"]];
}

- (IBAction)runTest {
	[self logMessage:[NSString stringWithFormat:@"runTest"]];
	HeavyOperation * op = [[HeavyOperation alloc] init];
	op.viewController = self;
	[_operationQueue addOperation:op];
	[op release];
}

- (IBAction)getJSON {
	_textView.text = [_updates JSONRepresentation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[_startTime release];
	[_updates release];
	[_locationManager stopUpdatingLocation];
	[_locationManager release];
    [super dealloc];
}

#pragma mark -

- (NSDictionary*)locationToDict:(CLLocation*)location {
	NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:6];
	[dict setObject:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"latitude"];
	[dict setObject:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"longitude"];
	[dict setObject:[NSNumber numberWithDouble:location.speed] forKey:@"speed"];
	[dict setObject:[NSNumber numberWithDouble:location.course] forKey:@"course"];
	[dict setObject:[NSNumber numberWithDouble:location.horizontalAccuracy] forKey:@"horizontalAccuracy"];	
	NSTimeInterval timeshift = [[location timestamp] timeIntervalSinceDate:_startTime];
	[dict setObject:[NSNumber numberWithDouble:timeshift] forKey:@"time"];
	return dict;
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:2];
	[dict setObject:[self locationToDict:oldLocation] forKey:@"from"];
	[dict setObject:[self locationToDict:newLocation] forKey:@"to"];
	NSTimeInterval timeshift = [[NSDate date] timeIntervalSinceDate:_startTime];
	[dict setObject:[NSNumber numberWithDouble:timeshift] forKey:@"time"];	 
	[_updates addObject:dict];
	
	[self logMessage:[NSString stringWithFormat:@"update"]];	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error {
	[self logMessage:[NSString stringWithFormat:@"ERROR: %@", error]];
}

@end
