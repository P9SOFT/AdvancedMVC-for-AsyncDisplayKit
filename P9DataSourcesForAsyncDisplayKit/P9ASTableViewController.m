//
//  P9ASTableViewController.m
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon on 3/22/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//

#import "P9ASTableViewController.h"
#import "P9DataSource_Private.h"


static void * const P9DataSourceContext = @"DataSourceContext";



@interface P9ASTableViewController() <P9DataSourceDelegate>

@end



@implementation P9ASTableViewController

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"dataSource" context:P9DataSourceContext];
}

- (void)loadView
{
    [super loadView];
    //  We need to know when the data source changes on the collection view so we can become the delegate for any APPLDataSource subclasses.
    [self.tableView addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:P9DataSourceContext];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    P9DataSource *dataSource = (P9DataSource *)self.tableView.dataSource;
    if ([dataSource isKindOfClass:[P9DataSource class]]) {
        [dataSource setNeedsLoadContent];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.editing = NO;
}

- (void)setTableView:(ASTableView *)tableView
{
    ASTableView *oldTableView = self.tableView;
    
    [oldTableView removeObserver:self forKeyPath:@"dataSource" context:P9DataSourceContext];
    
    [oldTableView addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:P9DataSourceContext];
    
    [self.view addSubview:self.tableView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //  For change contexts that aren't the data source, pass them to super.
    if (P9DataSourceContext != context) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    UICollectionView *collectionView = object;
    id<UICollectionViewDataSource> dataSource = collectionView.dataSource;
    
    if ([dataSource isKindOfClass:[P9DataSource class]]) {
        P9DataSource *aaplDataSource = (P9DataSource *)dataSource;
        if (!aaplDataSource.delegate)
            aaplDataSource.delegate = self;
    }
}



#pragma mark - P9DataSource methods

- (void)dataSource:(P9DataSource *)dataSource didRefreshSections:(NSIndexSet *)sections
{
    if (!sections)
        return;

    [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
}

- (void)dataSourceDidReloadData:(P9DataSource *)dataSource
{
    [self.tableView reloadData];
}


@end
