//
//  LocationDumpViewController.h
//  LocationDump
//
//  Created by Mikhail Kalugin on 12/23/09.
//  Copyright Mikhail Kalugin 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDumpViewController : UIViewController <CLLocationManagerDelegate> {
	IBOutlet UITextView * _textView;
	CLLocationManager * _locationManager;
	NSOperationQueue * _operationQueue;
}

- (IBAction)startUpdating;
- (IBAction)stopUpdating;
- (IBAction)runTest;

- (void)logMessage:(NSString*)message;

@end

