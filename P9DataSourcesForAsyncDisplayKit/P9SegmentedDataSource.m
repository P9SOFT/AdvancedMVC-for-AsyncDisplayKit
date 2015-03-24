//
//  P9SegmentedDataSource.m
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//

#import "P9SegmentedDataSource.h"
#import "P9DataSource_Private.h"

@interface P9SegmentedDataSource () <P9DataSourceDelegate>
@property (nonatomic, strong) NSMutableArray *mutableDataSources;
@end

@implementation P9SegmentedDataSource
//@synthesize mutableDataSources = _dataSources;


- (void)addDataSource:(P9DataSource *)dataSource
{
}

- (void)removeDataSource:(P9DataSource *)dataSource
{
}

- (void)removeAllDataSources
{
}

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
