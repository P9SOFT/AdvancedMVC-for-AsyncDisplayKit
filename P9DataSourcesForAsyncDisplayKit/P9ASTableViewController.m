//
//  P9ASTableViewController.m
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon on 3/22/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//

#import "P9ASTableViewController.h"
#import "P9DataSource_Private.h"



@interface P9ASTableViewController() <P9DataSourceDelegate>

@end



@implementation P9ASTableViewController



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
