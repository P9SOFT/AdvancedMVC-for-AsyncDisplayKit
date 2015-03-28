//
//  P9SegmentedDataSource.m
//  AdvancedMVCForAsyncDisplayKit
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

- (P9DataSource *)dataSourceForSectionAtIndex:(NSInteger)sectionIndex
{
    return [_selectedDataSource dataSourceForSectionAtIndex:sectionIndex];
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

- (void)setSelectedDataSourceIndex:(NSInteger)selectedDataSourceIndex
{
    [self setSelectedDataSourceIndex:selectedDataSourceIndex animated:NO];
}

- (void)setSelectedDataSourceIndex:(NSInteger)selectedDataSourceIndex animated:(BOOL)animated
{
    P9DataSource *dataSource = [_dataSources objectAtIndex:selectedDataSourceIndex];
    [self setSelectedDataSource:dataSource animated:animated completionHandler:nil];
}

- (void)setSelectedDataSource:(P9DataSource *)selectedDataSource
{
    [self setSelectedDataSource:selectedDataSource animated:NO completionHandler:nil];
}

- (void)setSelectedDataSource:(P9DataSource *)selectedDataSource animated:(BOOL)animated
{
    [self setSelectedDataSource:selectedDataSource animated:animated completionHandler:nil];
}

- (void)setSelectedDataSource:(P9DataSource *)selectedDataSource animated:(BOOL)animated completionHandler:(dispatch_block_t)handler
{
    if (_selectedDataSource == selectedDataSource) {
        if (handler)
            handler();
        return;
    }
    
    [self willChangeValueForKey:@"selectedDataSource"];
    [self willChangeValueForKey:@"selectedDataSourceIndex"];
    NSAssert([_dataSources containsObject:selectedDataSource], @"selected data source must be contained in this data source");
    
    P9DataSource *oldDataSource = _selectedDataSource;
    NSInteger numberOfOldSections = oldDataSource.numberOfSections;
    NSInteger numberOfNewSections = selectedDataSource.numberOfSections;
    
    P9DataSourceSectionOperationDirection direction = P9DataSourceSectionOperationDirectionNone;
    
    if (animated) {
        NSInteger oldIndex = [_dataSources indexOfObjectIdenticalTo:oldDataSource];
        NSInteger newIndex = [_dataSources indexOfObjectIdenticalTo:selectedDataSource];
        direction = (oldIndex < newIndex) ? P9DataSourceSectionOperationDirectionRight : P9DataSourceSectionOperationDirectionLeft;
    }
    
    NSIndexSet *removedSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, numberOfOldSections)];
    NSIndexSet *insertedSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, numberOfNewSections)];
    
    _selectedDataSource = selectedDataSource;
    
    [self didChangeValueForKey:@"selectedDataSource"];
    [self didChangeValueForKey:@"selectedDataSourceIndex"];
    
    // Update the sections all at once.
    [self notifyBatchUpdate:^{
        if (removedSet)
            [self notifySectionsRemoved:removedSet direction:direction];
        if (insertedSet)
            [self notifySectionsInserted:insertedSet direction:direction];
    } complete:handler];
    
    // If the newly selected data source has never been loaded, load it now
    //if ([selectedDataSource.loadingState isEqualToString:AAPLLoadStateInitial])
        [selectedDataSource setNeedsLoadContent];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_selectedDataSource itemAtIndexPath:indexPath];
}

- (NSArray *)indexPathsForItem:(id)object
{
    return [_selectedDataSource indexPathsForItem:object];
}

- (void)configureSegmentedControl:(UISegmentedControl *)segmentedControl
{
    NSArray *titles = [self.dataSources valueForKey:@"title"];
    
    [segmentedControl removeAllSegments];
    [titles enumerateObjectsUsingBlock:^(NSString *segmentTitle, NSUInteger segmentIndex, BOOL *stop) {
        if ([segmentTitle isEqual:[NSNull null]])
            segmentTitle = @"NULL";
        [segmentedControl insertSegmentWithTitle:segmentTitle atIndex:segmentIndex animated:NO];
    }];
    [segmentedControl addTarget:self action:@selector(selectedSegmentIndexChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = self.selectedDataSourceIndex;
}

#pragma mark - Header action method

- (void)selectedSegmentIndexChanged:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    if (![segmentedControl isKindOfClass:[UISegmentedControl class]])
        return;
    
    segmentedControl.userInteractionEnabled = NO;
    NSInteger selectedSegmentIndex = segmentedControl.selectedSegmentIndex;
    P9DataSource *dataSource = self.dataSources[selectedSegmentIndex];
    [self setSelectedDataSource:dataSource animated:NO completionHandler:^{
        segmentedControl.userInteractionEnabled = YES;
    }];
}



#pragma mark - Override

- (void)loadContent
{
    // Only load the currently selected data source. Others will be loaded as necessary.
    [_selectedDataSource loadContent];
}

- (void)resetContent
{
    for (P9DataSource *dataSource in self.dataSources)
        [dataSource resetContent];
    [super resetContent];
}



#pragma mark - ASTableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_selectedDataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_selectedDataSource tableView:tableView numberOfRowsInSection:section];
}

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_selectedDataSource tableView:tableView nodeForRowAtIndexPath:indexPath];
}



#pragma mark - P9DataSourceDelegate methods

- (void)dataSource:(P9DataSource *)dataSource didInsertSections:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction
{
    if (dataSource != _selectedDataSource)
        return;
    
    [self notifySectionsInserted:sections direction:direction];
}

- (void)dataSource:(P9DataSource *)dataSource didRemoveSections:(NSIndexSet *)sections direction:(P9DataSourceSectionOperationDirection)direction
{
    if (dataSource != _selectedDataSource)
        return;
    
    [self notifySectionsRemoved:sections direction:direction];
}

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

- (void)dataSource:(P9DataSource *)dataSource performBatchUpdate:(dispatch_block_t)update complete:(dispatch_block_t)complete
{
    if (dataSource != _selectedDataSource) {
        if (update)
            update();
        if (complete)
            complete();
        return;
    }
    
    [self notifyBatchUpdate:update complete:complete];
}


@end
