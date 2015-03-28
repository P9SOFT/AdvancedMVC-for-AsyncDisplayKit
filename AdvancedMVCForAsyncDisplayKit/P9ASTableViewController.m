//
//  P9ASTableViewController.m
//  AdvancedMVCForAsyncDisplayKit
//
//  Created by Simon Kim on 3/22/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9ASTableViewController.h"
#import "P9DataSource_Private.h"


static void * const P9DataSourceContext = @"DataSourceContext";
static NSString * const asyncDataSource = @"asyncDataSource";



@interface P9ASTableViewController() <P9DataSourceDelegate>

@end



@implementation P9ASTableViewController

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:asyncDataSource context:P9DataSourceContext];
}

- (void)loadView
{
    [super loadView];

    [self.tableView addObserver:self forKeyPath:asyncDataSource options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:P9DataSourceContext];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    P9DataSource *dataSource = (P9DataSource *)self.tableView.asyncDataSource;
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
    if(tableView == _tableView)
        return;
    
    [self.tableView removeObserver:self forKeyPath:asyncDataSource context:P9DataSourceContext];
    [self.tableView removeFromSuperview];

    [tableView addObserver:self forKeyPath:asyncDataSource options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:P9DataSourceContext];
    
    _tableView = tableView;
    
    [self.view addSubview:_tableView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (P9DataSourceContext != context) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    ASTableView *tableView = object;
    id<ASTableViewDataSource> dataSource = tableView.asyncDataSource;
    
    if ([dataSource isKindOfClass:[P9DataSource class]]) {
        P9DataSource *aaplDataSource = (P9DataSource *)dataSource;
        if (!aaplDataSource.delegate)
            aaplDataSource.delegate = self;
    }
}



#pragma mark - P9DataSourceDelegate methods

- (void)dataSource:(P9DataSource *)dataSource didRefreshSections:(NSIndexSet *)sections
{
    if (!sections)
        return;

    //[self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData]; // temporary test code!!!
}

- (void)dataSourceDidReloadData:(P9DataSource *)dataSource
{
    [self.tableView reloadData];
}

- (void)dataSource:(P9DataSource *)dataSource performBatchUpdate:(dispatch_block_t)update complete:(dispatch_block_t)complete
{
    /*
    [self.tableView performBatchUpdates:^{
        update();
    } completion:^(BOOL finished){
        if (complete) {
            complete();
        }
        [self.tableView reloadData];
    }];
     */

    if (complete) {
        complete();
    }

    [self.tableView reloadData];
}



@end
