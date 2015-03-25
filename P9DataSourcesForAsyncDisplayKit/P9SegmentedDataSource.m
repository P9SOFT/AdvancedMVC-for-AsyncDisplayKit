//
//  P9SegmentedDataSource.m
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9SegmentedDataSource.h"
#import "P9DataSource_Private.h"

@interface P9SegmentedDataSource () <P9DataSourceDelegate>
@property (nonatomic, strong) NSMutableArray *mutableDataSources;
@end

@implementation P9SegmentedDataSource
@synthesize mutableDataSources = _dataSources;


- (instancetype)init
{
    self = [super init];
    if (!self)
        return nil;
    
    _dataSources = [NSMutableArray array];
    
    return self;
}

- (NSInteger)numberOfSections
{
    return _selectedDataSource.numberOfSections;
}

- (NSArray *)dataSources
{
    return [NSArray arrayWithArray:_dataSources];
}

- (void)addDataSource:(P9DataSource *)dataSource
{
    if (![_dataSources count])
        _selectedDataSource = dataSource;
    [_dataSources addObject:dataSource];
    dataSource.delegate = self;
}

- (void)removeDataSource:(P9DataSource *)dataSource
{
    [_dataSources removeObject:dataSource];
    if (dataSource.delegate == self)
        dataSource.delegate = nil;
}

- (void)removeAllDataSources
{
    for (P9DataSource *dataSource in _dataSources) {
        if (dataSource.delegate == self)
            dataSource.delegate = nil;
    }
    
    _dataSources = [NSMutableArray array];
    _selectedDataSource = nil;
}

- (P9DataSource *)dataSourceAtIndex:(NSInteger)dataSourceIndex
{
    return _dataSources[dataSourceIndex];
}

- (NSInteger)selectedDataSourceIndex
{
    return [_dataSources indexOfObject:_selectedDataSource];
}

/*
- (void)setSelectedDataSourceIndex:(NSInteger)selectedDataSourceIndex
{
    [self setSelectedDataSourceIndex:selectedDataSourceIndex animated:NO];
}

- (void)setSelectedDataSourceIndex:(NSInteger)selectedDataSourceIndex animated:(BOOL)animated
{
    P9DataSource *dataSource = [_dataSources objectAtIndex:selectedDataSourceIndex];
    [self setSelectedDataSource:dataSource animated:animated completionHandler:nil];
}

- (void)setSelectedDataSource:(AAPLDataSource *)selectedDataSource
{
    [self setSelectedDataSource:selectedDataSource animated:NO completionHandler:nil];
}

- (void)setSelectedDataSource:(AAPLDataSource *)selectedDataSource animated:(BOOL)animated
{
    [self setSelectedDataSource:selectedDataSource animated:animated completionHandler:nil];
}
 */



// Override
- (void)resetContent
{
    for (P9DataSource *dataSource in self.dataSources)
        [dataSource resetContent];
    [super resetContent];
}



#pragma mark - P9DataSourceDelegate methods

- (void)dataSource:(P9DataSource *)dataSource didRefreshSections:(NSIndexSet *)sections
{
    if (dataSource != _selectedDataSource)
        return;
    
    [self notifySectionsRefreshed:sections];
}

- (void)dataSourceDidReloadData:(P9DataSource *)dataSource
{
    if (dataSource != _selectedDataSource)
        return;
    
    [self notifyDidReloadData];
}

@end
