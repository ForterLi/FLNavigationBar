//
//  FLBasegationController.h
//  FLBaseNavigationBar
//
//  Created by 李永强 on 2019/4/18.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLNavigationBarCommon.h"

/*
 * xib 或者 storyboard FLNavigationBar 替换 UINavigationBar
 */
NS_ASSUME_NONNULL_BEGIN

@interface FLBaseNavigationController : UINavigationController

- (instancetype)initWithNavigationBarClass:(nullable Class)navigationBarClass toolbarClass:(nullable Class)toolbarClass NS_UNAVAILABLE;

@property (nonatomic, assign) FLBarStyle barStyle;
@property (nonatomic, strong) UIColor *barLineColor;
@property (nonatomic, strong) UIColor *barBackgroundColor;
@property (nonatomic, assign) FLBlurEffectStyle barBlurEffectStyle;

/*
 * update bar
 * barStyle
 * barLineColor
 * barBackgroundColor
 * barBlurEffectStyle
 *
 */
- (void)barStyleUpdate;

@end

NS_ASSUME_NONNULL_END
