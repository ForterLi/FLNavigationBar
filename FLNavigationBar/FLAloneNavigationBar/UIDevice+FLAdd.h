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
//@property (nonatomic, readonly, class) NSString *platform;

@end

NS_ASSUME_NONNULL_END

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
//    return (kiPhone_X || kiPhone_XR || kiPhone_XS || kiPhone_XS_Max || deviceBang);
}
