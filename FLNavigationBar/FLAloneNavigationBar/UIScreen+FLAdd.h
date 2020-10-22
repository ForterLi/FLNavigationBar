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

/** 电池栏高度 */
#define kNavgationBarTopHeight FLNavgationBarTopHeight()
static inline CGFloat FLNavgationBarTopHeight() {
    CGFloat statusBarHeight = 20.;
    if (@available(iOS 11.0, *)) {
        statusBarHeight = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.top;
    }else{
        if (FLDeviceBang()) statusBarHeight = 44.;
    }
    return statusBarHeight;
}

#define kNavgationBarTopHeighOrientation FLNavgationBarTopHeighOrientation()
static inline CGFloat FLNavgationBarTopHeighOrientation() {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat height = 0.;
    switch (orientation) {
        case UIInterfaceOrientationPortrait :
        case UIInterfaceOrientationPortraitUpsideDown: {
            height = FLNavgationBarTopHeight();
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

#define kNavgationBarHeightOrientation FLNavgationBarHeightOrientation()
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
            if (kScreenWidth<= 375) {
                height = 32.;
            }else{
                height = 44.;
            }
            break;
        }
        default:
            break;
    }
    return  height;
}



/** 导航栏高度 电池栏高度 */
#define kNavgationBarAndStatusBarHeight  FLNavgationBarAndStatusBarHeight()
static inline CGFloat FLNavgationBarAndStatusBarHeight() {
    return FLNavgationBarTopHeight() + FLNavgationBarHeight();
}

NS_ASSUME_NONNULL_END
