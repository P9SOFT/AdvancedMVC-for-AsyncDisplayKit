//
//  P9DataSource.m
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9DataSource.h"
#import "P9DataSource_Private.h"

#define P9_ASSERT_MAIN_THREAD NSAssert([NSThread isMainThread], @"This method must be called on the main thread")



@implementation P9DataSource

- (NSInteger)numberOfSections
{
    return 1;
}

- (void)notifySectionsRefreshed:(NSIndexSet *)sections
{
    P9_ASSERT_MAIN_THREAD;
    
    id<P9DataSourceDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(dataSource:didRefreshSections:)]) {
        [delegate dataSource:self didRefreshSections:sections];
    }
}

- (void)notifyDidReloadData
{
    P9_ASSERT_MAIN_THREAD;
    
    id<P9DataSourceDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(dataSourceDidReloadData:)]) {
        [delegate dataSourceDidReloadData:self];
    }
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



#pragma mark - ASTableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"Should be implemented by subclasses");
    return nil;
}


@end
