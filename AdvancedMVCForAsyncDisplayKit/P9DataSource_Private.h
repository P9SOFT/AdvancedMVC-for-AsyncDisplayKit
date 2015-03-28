//
//  P9DataSource_Private.h
//  AdvancedMVCForAsyncDisplayKit
//
//  Created by Simon Kim on 3/20/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9DataSource.h"

@protocol P9DataSourceDelegate;

typedef enum {
    P9DataSourceSectionOperationDirectionNone = 0,
    P9DataSourceSectionOperationDirectionLeft,
    P9DataSourceSectionOperationDirectionRight,
} P9DataSourceSectionOperationDirection;


@interface P9DataSource ()
@property (nonatomic, weak) id<P9DataSourceDelegate> delegate;

- (void)notifySectionsInserted:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction;
- (void)notifySectionsRemoved:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction;

@end



@protocol P9DataSourceDelegate <NSObject>

@optional

- (void)dataSource:(P9DataSource *)dataSource didInsertSections:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction;
- (void)dataSource:(P9DataSource *)dataSource didRemoveSections:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction;

- (void)dataSource:(P9DataSource *)dataSource didRefreshSections:(NSIndexSet *)sections;

- (void)dataSourceDidReloadData:(P9DataSource *)dataSource;
- (void)dataSource:(P9DataSource *)dataSource performBatchUpdate:(dispatch_block_t)update complete:(dispatch_block_t)complete;

@end

