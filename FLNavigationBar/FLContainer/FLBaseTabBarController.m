//
//  FLBaseTabBarController.m
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/19.
//  Copyright © 2019 李永强. All rights reserved.
//

#import "FLBaseTabBarController.h"

@interface FLBaseTabBarController ()

@end

@implementation FLBaseTabBarController

#pragma mark - Life Cycle
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.selectedViewController preferredStatusBarStyle];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
}

@end
