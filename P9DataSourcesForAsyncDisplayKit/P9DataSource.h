//
//  P9DataSource.h
//  P9Common
//
//  Created by Simon Kim on 3/16/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P9DataSource : NSObject

@property (nonatomic, copy) NSString *title;


- (void)notifyDataRefreshed;
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
