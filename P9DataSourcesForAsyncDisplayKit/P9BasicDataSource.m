//
//  P9BasicDataSource.m
//  P9DataSourcesForAsyncDisplayKit
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

@end
