//
//  HeavyOperation.h
//  LocationDump
//
//  Created by Mikhail Kalugin on 12/23/09.
//  Copyright 2009 Mikhail Kalugin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationDumpViewController.h"

@interface HeavyOperation : NSOperation {
	LocationDumpViewController * _viewController;
}

@property (nonatomic, retain) LocationDumpViewController *viewController;

@end
