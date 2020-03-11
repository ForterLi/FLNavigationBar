//
//  UINavigationItem+AloneBar.h
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/22.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLNavigationBarCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationItem (FLBar)

@property (nonatomic, assign) FLBarStyle yq_barStyle;

@property (nonatomic, strong) UIColor *yq_barBackgroundColor;

@property (nonatomic, strong) UIColor *yq_barLineColor;

@property (nonatomic, assign) FLBlurEffectStyle yq_barBlurEffectStyle;

@property (nonatomic, assign) BOOL yq_customHidesBackButton;

@end

NS_ASSUME_NONNULL_END
