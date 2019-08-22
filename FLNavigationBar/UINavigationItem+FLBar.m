//
//  UINavigationItem+AloneBar.m
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/22.
//  Copyright © 2019 李永强. All rights reserved.
//

#import "UINavigationItem+FLBar.h"
#import "FLNavigationBar.h"
#import <objc/runtime.h>

@implementation UINavigationItem (FLBar)

- (FLBarStyle)yq_barStyle {
    NSInteger style = [objc_getAssociatedObject(self, _cmd) integerValue];
    return style;
}
- (void)setYq_barStyle:(FLBarStyle)yq_barStyle {
    if (self.yq_barStyle == yq_barStyle) {
        return;
    }
    objc_setAssociatedObject(self, @selector(yq_barStyle), [NSNumber numberWithInteger:yq_barStyle], OBJC_ASSOCIATION_ASSIGN);
}


- (UIColor *)yq_barBackgroundColor {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    return color;
}
- (void)setYq_barBackgroundColor:(UIColor *)yq_barBackgroundColor {
    objc_setAssociatedObject(self, @selector(yq_barBackgroundColor), yq_barBackgroundColor, OBJC_ASSOCIATION_RETAIN);
}


- (UIColor *)yq_barLineColor {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    return color;
}
- (void)setYq_barLineColor:(UIColor *)yq_barLineColor {
    objc_setAssociatedObject(self, @selector(yq_barLineColor), yq_barLineColor, OBJC_ASSOCIATION_RETAIN);
}

- (FLBlurEffectStyle)yq_barBlurEffectStyle {
    NSInteger style = [objc_getAssociatedObject(self, _cmd) integerValue];
    return style;
}
- (void)setYq_barBlurEffectStyle:(FLBlurEffectStyle)yq_barBlurEffectStyle {
    if (self.yq_barBlurEffectStyle == yq_barBlurEffectStyle) {
        return;
    }
    objc_setAssociatedObject(self, @selector(yq_barBlurEffectStyle), [NSNumber numberWithInteger:yq_barBlurEffectStyle], OBJC_ASSOCIATION_ASSIGN);
}


@end
