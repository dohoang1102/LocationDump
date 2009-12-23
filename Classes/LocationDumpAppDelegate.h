//
//  LocationDumpAppDelegate.h
//  LocationDump
//
//  Created by Mikhail Kalugin on 12/23/09.
//  Copyright Mikhail Kalugin 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationDumpViewController;

@interface LocationDumpAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LocationDumpViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LocationDumpViewController *viewController;

@end

