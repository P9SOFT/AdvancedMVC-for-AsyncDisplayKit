//
//  P9DataSource.h
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//
//  Licensed under the MIT license.

#import "AsyncDisplayKit.h"

@interface P9DataSource : NSObject <ASTableViewDataSource>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) NSInteger numberOfSections;


/// Find the data source for the given section. Default implementation returns self.
- (P9DataSource *)dataSourceForSectionAtIndex:(NSInteger)sectionIndex;

/// Find the item at the specified index path.
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/// Find the index paths of the specified item in the data source. An item may appear more than once in a given data source.
- (NSArray*)indexPathsForItem:(id)item;

- (void)notifySectionsInserted:(NSIndexSet *)sections;
- (void)notifySectionsRemoved:(NSIndexSet *)sections;
- (void)notifySectionsRefreshed:(NSIndexSet *)sections;

- (void)notifyDidReloadData;

- (void)notifyBatchUpdate:(dispatch_block_t)update;
- (void)notifyBatchUpdate:(dispatch_block_t)update complete:(dispatch_block_t)complete;



#pragma mark - Placeholders

@property (nonatomic, copy) NSString *noContentTitle;
@property (nonatomic, copy) NSString *noContentMessage;
@property (nonatomic, strong) UIImage *noContentImage;

@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, copy) NSString *errorTitle;
@property (nonatomic, strong) UIImage *errorImage;



#pragma mark - Subclass hooks

- (void)setNeedsLoadContent;

- (void)resetContent NS_REQUIRES_SUPER;

/// Load the content of this data source.
- (void)loadContent;



@end
