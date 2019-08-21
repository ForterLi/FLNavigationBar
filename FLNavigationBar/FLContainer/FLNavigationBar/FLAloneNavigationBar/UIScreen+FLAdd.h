//
//  UIScreen+FLAdd.h
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/19.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice+FLAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (FLAdd)

+ (NSArray *)preferredScales;

+ (CGFloat)navigationBarSpace;

@end

/** 电池栏高度 */
#define kStatusBarHeight FLStatusBarHeight()
static inline CGFloat FLStatusBarHeight() {
    CGFloat statusBarHeight = 20.;
    if(FLDeviceBang())statusBarHeight = 44.;
    return statusBarHeight;
}

#define kStatusBarHeighOrientation() FLStatusBarHeighOrientation()
static inline CGFloat FLStatusBarHeighOrientation() {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat height = 0.;
    switch (orientation) {
        case UIInterfaceOrientationPortrait :
        case UIInterfaceOrientationPortraitUpsideDown: {
            height = FLStatusBarHeight();
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        case  UIInterfaceOrientationLandscapeRight: {
            height = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        default:
            break;
    }
    return  height;
}

/** 导航栏高度 */
#define kNavgationBarHeight FLNavgationBarHeight()
static inline CGFloat FLNavgationBarHeight() {
    return 44.;
}

#define kNavgationBarHeightOrientation() FLNavgationBarHeightOrientation()
static inline CGFloat FLNavgationBarHeightOrientation() {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat height = 0.;
    switch (orientation) {
        case UIInterfaceOrientationPortrait :
        case UIInterfaceOrientationPortraitUpsideDown: {
            height = 44;
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        case  UIInterfaceOrientationLandscapeRight: {
            if (kiPhone_4  || kiPhone_4S || kiPhone_5 || kiPhone_5c || kiPhone_5s || kiPhone_6 || kiPhone_6 || kiPhone_7 || kiPhone_8 || kiPhone_X || kiPhone_SE || kiPhone_XS) {
                height = 32.;
            }
            if (kiPhone_6_Plus || kiPhone_7_Plus || kiPhone_8_Plus || kiPhone_XS_Max || kiPhone_XR) {
                height = 44.;
            }
            break;
        }
        default:
            break;
    }
    return  height;
}

/** TabBar高度 */
#define kTabBarHeight FLTabBarHeight()
static inline CGFloat FLTabBarHeight() {
    CGFloat tabBarHeight = 49.;
    if(FLDeviceBang())tabBarHeight = 83.;
    return tabBarHeight;
}

/** 底部安全距离 */
#define kSafeAreaBottom FLSafeAreaBottom()
static inline CGFloat FLSafeAreaBottom() {
    CGFloat safeAreaBottom = 0.;
    if(FLDeviceBang())safeAreaBottom = 34.;
    return safeAreaBottom;
}

/** 顶部安全距离 */
#define kSafeAreaTop FLSafeAreaTop()
static inline CGFloat FLSafeAreaTop() {
    CGFloat safeAreaTop = 0.;
    if(FLDeviceBang())safeAreaTop = 24.;
    return safeAreaTop;
}


/** 导航栏高度 电池栏高度 */
#define kNavgationBarAndStatusBarHeight  FLNavgationBarAndStatusBarHeight()
static inline CGFloat FLNavgationBarAndStatusBarHeight() {
    return FLStatusBarHeight() + FLNavgationBarHeight();
}

/** 主屏幕的bounds */
#define kScreenBounds FLScreenBounds()
static inline CGRect FLScreenBounds() {
    return [UIScreen mainScreen].bounds;
}

/** 主屏幕的宽高 */
#define kScreenSize FLScreenSize()
static inline CGSize FLScreenSize() {
    return [UIScreen mainScreen].bounds.size;
}

/** 主屏幕的高度 */
#define kScreenHeight FLScreenHeight()
static inline CGFloat FLScreenHeight() {
    return FLScreenSize().height;
}

/** 主屏幕的宽度 */
#define kScreenWidth FLScreenWidth()
static inline CGFloat FLScreenWidth() {
    return FLScreenSize().width;
}

///** 一像素大小 */
//#define kOnePixelSeperatorHeight ([[UIScreen mainScreen] scale]>1.0?([[UIScreen mainScreen] scale]>2.0?1.0/3:1.0/2):1.0)
///** 0.5像素 */
//#define kZeroFivePixelSeperatorHeight ([[UIScreen mainScreen] scale]>1.0?([[UIScreen mainScreen] scale]>2.0?.5/3:.5/2):.5)



NS_ASSUME_NONNULL_END
