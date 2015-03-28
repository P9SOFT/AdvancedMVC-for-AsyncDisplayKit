//
//  P9SegmentedDataSource.h
//  AdvancedMVCForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9DataSource.h"

@interface P9SegmentedDataSource : P9DataSource

@property (nonatomic, readonly) NSArray *dataSources;
@property (nonatomic) BOOL shouldDisplayDefaultHeader;
@property (nonatomic, strong) P9DataSource *selectedDataSource;
@property (nonatomic) NSInteger selectedDataSourceIndex;

- (void)addDataSource:(P9DataSource *)dataSource;
- (void)removeDataSource:(P9DataSource *)dataSource;
- (void)removeAllDataSources;

/// Set the selected data source with animation. By default, setting the selected data source is not animated.
- (void)setSelectedDataSource:(P9DataSource *)selectedDataSource animated:(BOOL)animated;

/// Set the index of the selected data source with optional animation. By default, setting the selected data source index is not animated.
- (void)setSelectedDataSourceIndex:(NSInteger)selectedDataSourceIndex animated:(BOOL)animated;

/// Call this method to configure a segmented control with the titles of the data sources. This method also sets the target & action of the segmented control to switch the selected data source.
- (void)configureSegmentedControl:(UISegmentedControl *)segmentedControl;

@end
