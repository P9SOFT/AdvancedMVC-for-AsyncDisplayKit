//
//  P9BasicDataSource.m
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//

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
    [self notifyDataRefreshed];
}

@end
