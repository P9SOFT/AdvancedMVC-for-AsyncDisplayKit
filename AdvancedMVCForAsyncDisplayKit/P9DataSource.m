//
//  P9DataSource.m
//  AdvancedMVCForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9DataSource.h"
#import "P9DataSource_Private.h"

#define P9_ASSERT_MAIN_THREAD NSAssert([NSThread isMainThread], @"This method must be called on the main thread")



@implementation P9DataSource

- (P9DataSource *)dataSourceForSectionAtIndex:(NSInteger)sectionIndex
{
    return self;
}

- (NSInteger)numberOfSections
{
    return 1;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"Should be implemented by subclasses");
    return nil;
}

- (NSArray *)indexPathsForItem:(id)object
{
    NSAssert(NO, @"Should be implemented by subclasses");
    return nil;
}

- (void)notifySectionsInserted:(NSIndexSet *)sections
{
    [self notifySectionsInserted:sections direction:P9DataSourceSectionOperationDirectionNone];
}

- (void)notifySectionsInserted:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction
{
    P9_ASSERT_MAIN_THREAD;
    
    id<P9DataSourceDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(dataSource:didInsertSections:direction:)]) {
        [delegate dataSource:self didInsertSections:sections direction:direction];
    }
}

- (void)notifySectionsRemoved:(NSIndexSet *)sections
{
    [self notifySectionsRemoved:sections direction:P9DataSourceSectionOperationDirectionNone];
}

- (void)notifySectionsRemoved:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction
{
    P9_ASSERT_MAIN_THREAD;
    
    id<P9DataSourceDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(dataSource:didRemoveSections:direction:)]) {
        [delegate dataSource:self didRemoveSections:sections direction:direction];
    }
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

- (void)notifyBatchUpdate:(dispatch_block_t)update
{
    [self notifyBatchUpdate:update complete:nil];
}

- (void)notifyBatchUpdate:(dispatch_block_t)update complete:(dispatch_block_t)complete
{
    P9_ASSERT_MAIN_THREAD;
    
    id<P9DataSourceDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(dataSource:performBatchUpdate:complete:)]) {
        [delegate dataSource:self performBatchUpdate:update complete:complete];
    }
    else {
        if (update) {
            update();
        }
        if (complete) {
            complete();
        }
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
