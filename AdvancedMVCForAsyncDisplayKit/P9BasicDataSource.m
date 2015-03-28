//
//  P9BasicDataSource.m
//  AdvancedMVCForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "P9BasicDataSource.h"

@implementation P9BasicDataSource

// Override
- (void)resetContent
{
    [super resetContent];
    self.items = @[];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger itemIndex = indexPath.item;
    if (itemIndex < [_items count])
        return _items[itemIndex];
    
    return nil;
}

- (NSArray *)indexPathsForItem:(id)item
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger objectIndex, BOOL *stop) {
        if ([obj isEqual:item])
            [indexPaths addObject:[NSIndexPath indexPathForItem:objectIndex inSection:0]];
    }];
    return indexPaths;
}

-(void) setItems:(NSArray *)items
{
    if (_items == items || [_items isEqualToArray:items])
        return;
    
    _items = [items copy];
    [self notifySectionsRefreshed:[NSIndexSet indexSetWithIndex:0]];
}



#pragma mark - ASTableViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

@end
