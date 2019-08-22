//
//  FLNavigationPrivate.h
//  FLBaseKit
//
//  Created by 李永强 on 2019/8/15.
//  Copyright © 2019 李永强. All rights reserved.
//

#import "FLNavigationBar.h"
#import "FLAloneNavigationBar.h"
#import "FLNavigationBarCommon.h"

@interface FLNavigationBar (Private)

@property UINavigationController *currentNavigationController;
@property FLBarStyle barCustomStyle;
@property FLBlurEffectStyle barBlurEffectStyle;
@property UIColor *barLineColor;
@property UIColor *barBackgroundColor;

- (void)updateNavigation:(id<UIViewControllerTransitionCoordinatorContext>)context;
- (void)endNavigation:(UIViewController *)currentVC;
- (void)barStyleUpdate;

@end


@interface FLAloneNavigationBar (Private)

@property (nonatomic, class, assign) CGRect barFrame;

@end
