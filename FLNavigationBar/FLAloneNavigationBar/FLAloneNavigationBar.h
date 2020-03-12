//
//  FLAloneNavigationBar.h
//  FLBaseKit
//
//  Created by 李永强 on 2019/8/19.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLNavigationBar.h"
#import "FLNavigationBarCommon.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLAloneNavigationBar : FLNavigationBar

@property (nonatomic) FLAloneBarStyle barCustomStyle;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *lineShadowColor;
@property (nonatomic, assign) UIBlurEffectStyle effectStyle;
 
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
