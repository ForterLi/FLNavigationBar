//
//  SYCBaseNavigationController.m
//  SYBaseNavigationBar
//
//  Created by 李永强 on 2019/4/18.
//  Copyright © 2019 李永强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLBaseNavigationController.h"
#import "FLNavigationBarPrivate.h"
#import "UIViewController+FLBar.h"
#import "FLNavigationPopDelegate.h"
#import "UINavigationItem+FLBar.h"



@interface FLBaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>


@end

@implementation FLBaseNavigationController {
    __weak FLNavigationBar *_baseNavigationBar;
    __weak UIPanGestureRecognizer *_fullScreenPopPanGesture;
    NSInteger _currentChildCount;
}

#pragma mark - Class Public Methods
#pragma mark - Instance Public Methods
- (void)barStyleUpdate {
    [_baseNavigationBar barStyleUpdate];
}


#pragma mark - Life Cycle
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithNavigationBarClass:[FLNavigationBar class] toolbarClass:nil];
    if (self) {
        self.viewControllers = @[rootViewController];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self setupViews];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *fullScreenPopPanGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    fullScreenPopPanGesture.delegate = self;
    [self.view addGestureRecognizer:fullScreenPopPanGesture];
    [self.interactivePopGestureRecognizer requireGestureRecognizerToFail:fullScreenPopPanGesture];
    _fullScreenPopPanGesture = fullScreenPopPanGesture;
    
    self.interactivePopGestureRecognizer.delegate = (id)self;
    [self endBar:self.topViewController];
}

#pragma mark - Delegate
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self startBar];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self endBar:viewController];
}

#pragma mark - Event Reponse
- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController preferredStatusBarStyle];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.childViewControllers.count < 2) {
        return NO;
    }

    UIViewController<FLNavigationPopDelegate> *currentVC = ((UIViewController <FLNavigationPopDelegate> *)self.topViewController);
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (currentVC.interactivePopEnabled == NO) {
            return NO;
        }
        
        if ([currentVC respondsToSelector:@selector(interactiveShouldPopOnBack)]) {
            if ([currentVC interactiveShouldPopOnBack] == NO) {
                return NO;
            }
        }
    }
    
    if (gestureRecognizer == _fullScreenPopPanGesture) {
    
        if (currentVC.fullScreenPopEnabled == NO) {
            return NO;
        }
        
        if ([currentVC respondsToSelector:@selector(fullScreenShouldPopOnBack)]) {
            if ([currentVC fullScreenShouldPopOnBack] == NO) {
                return NO;
            }
        }
        
        CGPoint point = [_fullScreenPopPanGesture velocityInView:self.view];
        if (fabs(point.x) > fabs(point.y) && point.x > 0){}else{
            return  NO;
        }
    }
    return YES;
}

#pragma mark - Notification
#pragma mark - Instance Private Methods
// MARK: 视图初始化
- (void)setupViews {
    NSAssert([self.navigationBar isKindOfClass:[FLNavigationBar class]], @"no FLNavigationBar class");
    _baseNavigationBar = (FLNavigationBar *)self.navigationBar;
}

#pragma mark - Class Private Methods
#pragma mark - Modules
#pragma mark - Setters
- (void)setBarStyle:(FLBarStyle)barStyle {
    _barStyle = barStyle;
    _baseNavigationBar.barCustomStyle = barStyle;
}

- (void)setBarLineColor:(UIColor *)barLineColor {
    _barLineColor = barLineColor;
    _baseNavigationBar.barLineColor = barLineColor;
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    _barBackgroundColor = barBackgroundColor;
    _baseNavigationBar.barBackgroundColor = barBackgroundColor;
}

- (void)setBarBlurEffectStyle:(FLBlurEffectStyle)barBlurEffectStyle {
    _barBlurEffectStyle = barBlurEffectStyle;
    _baseNavigationBar.barBlurEffectStyle = barBlurEffectStyle;
}

#pragma mark - Getters




@end
