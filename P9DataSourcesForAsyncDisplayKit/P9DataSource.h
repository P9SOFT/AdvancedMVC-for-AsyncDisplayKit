//
//  P9DataSource.h
//  P9DataSourcesForAsyncDisplayKit
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface P9DataSource : NSObject <ASTableViewDataSource>

@property (nonatomic, copy) NSString *title;


- (void)notifySectionsRefreshed:(NSIndexSet *)sections;
- (void)notifyDidReloadData;


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
