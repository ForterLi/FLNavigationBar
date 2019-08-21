//
//  UIDevice+FLAdd.h
//  chic
//
//  Created by forterli on 2017/8/17.
//  Copyright © 2017年 forterli. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (FLAdd)
// 系统版本
+ (double)systemVersion;
/**
 设备
 */
@property (nonatomic, readonly, class) NSString *platform;

@end

NS_ASSUME_NONNULL_END


#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS6
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10)
#endif

#ifndef kiOS11Later
#define kiOS11Later (kSystemVersion >= 11)
#endif

#ifndef kiOS12Later
#define kiOS12Later (kSystemVersion >= 12)
#endif

#ifndef kIsiOS8
#define kIsiOS8 (kSystemVersion >= 8.0 && kSystemVersion < 9.0)
#endif

#ifndef kIsiOS9
#define kIsiOS9 (kSystemVersion >= 9.0 && kSystemVersion < 10.0)
#endif

#ifndef kIsiOS10
#define kIsiOS10 (kSystemVersion >= 10.0 && kSystemVersion < 11.0)
#endif

#ifndef kIsiOS11
#define kIsiOS11 (kSystemVersion >= 11.0 && kSystemVersion < 12.0)
#endif

#ifndef kIsiOS12
#define kIsiOS12 (kSystemVersion >= 12.0 && kSystemVersion < 13.0)
#endif

#ifndef kiPhone_4
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_4 [[UIDevice platform] isEqualToString:@"iPhone 4"]
#endif
#endif

#ifndef kiPhone_4S
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_4S [[UIDevice platform] isEqualToString:@"iPhone 4S"]
#endif
#endif

#ifndef kiPhone_5
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_5 [[UIDevice platform] isEqualToString:@"iPhone 5"]
#endif
#endif

#ifndef kiPhone_5c
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_5c [[UIDevice platform] isEqualToString:@"iPhone 5c"]
#endif
#endif

#ifndef kiPhone_5s
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_5s [[UIDevice platform] isEqualToString:@"iPhone5s"]
#endif
#endif

#ifndef kiPhone_SE
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_SE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_SE [[UIDevice platform] isEqualToString:@"iPhone SE"]
#endif
#endif

#ifndef kiPhone_6
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_6 [[UIDevice platform] isEqualToString:@"iPhone 6"]
#endif
#endif

#ifndef kiPhone_6s
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_6s [[UIDevice platform] isEqualToString:@"iPhone 6s"]
#endif
#endif

#ifndef kiPhone_7
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_7 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_7 [[UIDevice platform] isEqualToString:@"iPhone 7"]
#endif
#endif


#ifndef kiPhone_8
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_8 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_8 [[UIDevice platform] isEqualToString:@"iPhone 8"]
#endif
#endif

#ifndef kiPhone_6_Plus
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_6_Plus [[UIDevice platform] isEqualToString:@"iPhone 6 Plus"]
#endif
#endif


#ifndef kiPhone_6s_Plus
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_6s_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_6s_Plus [[UIDevice platform] isEqualToString:@"iPhone 6s Plus"]
#endif
#endif


#ifndef kiPhone_7_Plus
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_7_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_7_Plus [[UIDevice platform] isEqualToString:@"iPhone 7 Plus"]
#endif
#endif

#ifndef kiPhone_8_Plus
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_8_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#else
#define kiPhone_8_Plus [[UIDevice platform] isEqualToString:@"iPhone 8 Plus"]
#endif
#endif

#ifndef kiPhone_X
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_X [[UIDevice platform] isEqualToString:@"iPhone X"]
#endif
#endif


#ifndef kiPhone_XS
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_XS [[UIDevice platform] isEqualToString:@"iPhone XS"]
#endif
#endif

#ifndef kiPhone_XR
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_XR [[UIDevice platform] isEqualToString:@"iPhone XR"]
#endif
#endif

#ifndef kiPhone_XS_Max
#if TARGET_IPHONE_SIMULATOR
#define kiPhone_XS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#else
#define kiPhone_XS_Max [[UIDevice platform] isEqualToString:@"iPhone XS Max"]
#endif
#endif

/// MARK: 刘海设备
static inline BOOL FLDeviceBang() {
    BOOL deviceBang = NO;
    if (@available(iOS 11.0, *)) {
        deviceBang = ([UIApplication sharedApplication].windows.firstObject.safeAreaInsets.top > 20)?YES:NO;
    }
    return (kiPhone_X || kiPhone_XR || kiPhone_XS || kiPhone_XS_Max || deviceBang);
}
