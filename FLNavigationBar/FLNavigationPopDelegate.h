//
//  FLNavigationPopDelegate.h
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/22.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FLNavigationPopDelegate <NSObject>

@optional
- (BOOL)barNavigationShouldPopOnBackButton;

- (BOOL)interactiveShouldPopOnBack;

- (BOOL)fullScreenShouldPopOnBack;

@end

NS_ASSUME_NONNULL_END
