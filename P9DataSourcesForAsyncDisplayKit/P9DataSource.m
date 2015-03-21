//
//  P9DataSource.m
//  P9Common
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//

#import "P9DataSource.h"
#import "P9DataSource_Private.h"

#define P9_ASSERT_MAIN_THREAD NSAssert([NSThread isMainThread], @"This method must be called on the main thread")



@implementation P9DataSource

- (void)notifyDataRefreshed
{
    P9_ASSERT_MAIN_THREAD;
    
//    id<P9DataSourceDelegate> delegate = self.delegate;
//    if ([delegate respondsToSelector:@selector(dataSource:notifyDataRefreshed)]) {
//        [delegate dataSource:self didRefreshSections:sections];
//    }
}

- (void)notifyDidReloadData
{
    
}



#pragma mark - Subclass hooks

- (void)setNeedsLoadContent
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadContent) object:nil];
    [self performSelector:@selector(loadContent) withObject:nil afterDelay:0];
}

- (void)resetContent
{
}

- (void)loadContent
{
    // To be implemented by subclasses…
}


@end
