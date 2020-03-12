//
//  UIViewController+AloneBar.h
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/23.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLAloneNavigationBar;

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (FLBar)

- (void)startBar;

- (void)endBar:(UIViewController *)viewController;

@end


@interface UIViewController (FLBar)

- (void)yq_barStyleUpdate;

@end


/**
 - (void)viewDidLoad {
 [super viewDidLoad];
 [self addAloneBarNavigationBar];
 }
 
 - (void)viewDidLayoutSubviews {
 [super viewDidLayoutSubviews];
 [self aloneBarViewDidLayoutSubviews];
 }
 */

@interface UIViewController (Alone)

@property (nonatomic, readonly) UINavigationBar *alone_barNavigationBar;

@property (nonatomic, readonly) UINavigationItem *alone_navigationItem;

- (void)addAloneBarNavigationBar;

- (void)removeAloneBarNavigationBar;

- (void)aloneBarViewDidLayoutSubviews;
@end



@interface UIViewController (FLPop)

@property BOOL fullScreenPopEnabled;

@property BOOL interactivePopEnabled;

@end


@interface  UIViewController (FLBackButton)
/*
 * 添加返回按钮
 */
- (void)addBackButton;

@end


NS_ASSUME_NONNULL_END
