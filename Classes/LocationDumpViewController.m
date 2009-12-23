//
//  LocationDumpViewController.m
//  LocationDump
//
//  Created by Mikhail Kalugin on 12/23/09.
//  Copyright Mikhail Kalugin 2009. All rights reserved.
//

#import "LocationDumpViewController.h"
#import "HeavyOperation.h"

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
	[_locationManager startUpdatingLocation];
	[self logMessage:[NSString stringWithFormat:@"startUpdating"]];
}

- (IBAction)stopUpdating {
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
	[_locationManager stopUpdatingLocation];
	[_locationManager release];
    [super dealloc];
}

#pragma mark -

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	[self logMessage:[NSString stringWithFormat:@"update from %@ to %@", newLocation, oldLocation]];	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error {
	[self logMessage:[NSString stringWithFormat:@"ERROR: %@", error]];
}

@end
