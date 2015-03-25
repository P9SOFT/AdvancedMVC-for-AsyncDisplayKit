//
//  P9DataSource_Private.h
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/20/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9DataSource.h"

@protocol P9DataSourceDelegate;



@interface P9DataSource ()
@property (nonatomic, weak) id<P9DataSourceDelegate> delegate;
@end



@protocol P9DataSourceDelegate <NSObject>

@optional
- (void)dataSourceDidReloadData:(P9DataSource *)dataSource;
- (void)dataSource:(P9DataSource *)dataSource didRefreshSections:(NSIndexSet *)sections;

@end

