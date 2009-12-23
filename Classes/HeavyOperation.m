//
//  HeavyOperation.m
//  LocationDump
//
//  Created by Mikhail Kalugin on 12/23/09.
//  Copyright 2009 Mikhail Kalugin. All rights reserved.
//

#import "HeavyOperation.h"


@implementation HeavyOperation

@synthesize viewController = _viewController;

- (void)dealloc
{
	[_viewController release];
	_viewController = nil;

	[super dealloc];
}

- (void)main {
	NSDate * start = [NSDate date];
	int count = 10000;
	NSMutableArray * array = [NSMutableArray arrayWithCapacity:count];
	for (int i = 0; i < count; i++) {
		[array addObject:[NSNumber numberWithInt:(count - i)]];
	}
	[array sortUsingSelector:@selector(compare:)];
	NSDate * end = [NSDate date];
	NSString * message = [NSString stringWithFormat:@"sorting %d ints took %f", 
						  count, [end timeIntervalSinceDate:start]];
	[_viewController performSelectorOnMainThread:@selector(logMessage:) 
									  withObject:message 
								   waitUntilDone:NO];
}

@end
