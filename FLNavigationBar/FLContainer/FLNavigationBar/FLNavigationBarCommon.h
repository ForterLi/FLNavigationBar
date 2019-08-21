//
//  FLNavigationBarCommon.h
//  FLNavigationBar
//
//  Created by 李永强 on 2019/8/21.
//  Copyright © 2019 李永强. All rights reserved.
//

#ifndef FLNavigationBarCommon_h
#define FLNavigationBarCommon_h


typedef NS_ENUM(NSInteger, FLBarStyle) {
    FLBarStyleNone = 0,
    FLBarStyleDefault = 0xff,         // 毛玻璃效果
    FLBarStyleColor,                  // 颜色
    FLBarStyleTransparent,            // 透明
    FLBarStyleHidden,                 // 隐藏
};

typedef NS_ENUM(NSInteger, FLBlurEffectStyle) {
    FLBlurEffectStyleNone = 0,
    FLBlurEffectStyleExtraLight,
    FLBlurEffectStyleLight,
    FLBlurEffectStyleDark
};

#endif /* FLNavigationBarCommon_h */
