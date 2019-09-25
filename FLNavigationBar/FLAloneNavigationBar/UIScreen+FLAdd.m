//
//  UIScreen+FLAdd.m
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/19.
//  Copyright © 2019 李永强. All rights reserved.
//

#import "UIScreen+FLAdd.h"


@implementation UIScreen (FLAdd)

+ (NSArray *)preferredScales {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1,@2,@3];
        } else if (screenScale <= 2) {
            scales = @[@2,@3,@1];
        } else {
            scales = @[@3,@2,@1];
        }
    });
    return scales;
}

+ (CGFloat)navigationBarSpace {
    static CGFloat space;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (kScreenWidth > 375) {
            space = 20;
        } else {
            space = 16;
        }
    });
    return space;
}

@end
