//
//  UIViewController+AloneBar.h
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/23.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <UIKit/UIKit.h>

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

- (void)aloneBarViewDidLayoutSubviews;

@end



NS_ASSUME_NONNULL_END
