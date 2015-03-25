//
//  P9SegmentedDataSource.h
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9DataSource.h"

@interface P9SegmentedDataSource : P9DataSource

- (void)addDataSource:(P9DataSource *)dataSource;
- (void)removeDataSource:(P9DataSource *)dataSource;
- (void)removeAllDataSources;

@property (nonatomic, readonly) NSArray *dataSources;
@property (nonatomic, strong) P9DataSource *selectedDataSource;

@end
