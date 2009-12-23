//
//  LocationDumpAppDelegate.m
//  LocationDump
//
//  Created by Mikhail Kalugin on 12/23/09.
//  Copyright Mikhail Kalugin 2009. All rights reserved.
//

#import "LocationDumpAppDelegate.h"
#import "LocationDumpViewController.h"

@implementation LocationDumpAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
