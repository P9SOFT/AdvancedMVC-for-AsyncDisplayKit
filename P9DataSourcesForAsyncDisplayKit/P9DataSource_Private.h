//
//  P9DataSource_Private.h
//  P9Common
//
//  Created by Simon on 3/20/15.
//  Copyright (c) 2015 P9 SOFT, Inc. All rights reserved.
//


#import "P9DataSource.h"

@protocol P9DataSourceDelegate;



@interface P9DataSource ()
@property (nonatomic, weak) id<P9DataSourceDelegate> delegate;
@end



@protocol P9DataSourceDelegate <NSObject>
@optional

@end

