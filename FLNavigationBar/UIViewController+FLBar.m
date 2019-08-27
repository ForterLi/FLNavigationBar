//
//  UIViewController+AloneBar.m
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/23.
//  Copyright © 2019 李永强. All rights reserved.
//

#import "UIViewController+FLBar.h"
#import "FLNavigationBarPrivate.h"


@implementation UINavigationController (FLBar)

- (void)startBar {
    if (![self.navigationBar isKindOfClass:FLNavigationBar.class]) {
        return;
    }
    FLNavigationBar *bar = (FLNavigationBar *)self.navigationBar;
    [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [bar updateNavigation:context];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [bar endNavigation:self.topViewController];
    }];
}

- (void)endBar:(UIViewController *)viewController {
    if (![self.navigationBar isKindOfClass:FLNavigationBar.class]) {
        return;
    }
    FLNavigationBar *bar = (FLNavigationBar *)self.navigationBar;
    [bar endNavigation:viewController];
}

@end


@implementation UIViewController (FLBar)

- (void)yq_barStyleUpdate {
    if ([self.navigationController.navigationBar isKindOfClass:FLNavigationBar.class]) {
        FLNavigationBar *bar = (FLNavigationBar *)self.navigationController.navigationBar;
        if (self.navigationItem != bar.topItem) {
            return;
        }
        [bar barStyleUpdate];
    }
}

@end




static NSMapTable * mapVC() {
    static NSMapTable *map;
    if (!map) {
        map = [NSMapTable weakToStrongObjectsMapTable];
    }
    return map;
}

@implementation UIViewController (Alone)

- (void)addAloneBarNavigationBar {
    FLAloneNavigationBar *bar = self.aloneBarNavigationBar;
    [self.view addSubview:bar];
}


- (void)aloneBarViewDidLayoutSubviews {
    FLAloneNavigationBar *bar = [mapVC() objectForKey:self];
    if (bar && bar.superview == self.view) {
        [self.view bringSubviewToFront:bar];
    }
}


- (FLAloneNavigationBar *)aloneBarNavigationBar {
    FLAloneNavigationBar *bar = [mapVC() objectForKey:self];
    if (!bar) {
        bar = [[FLAloneNavigationBar alloc] init];
        [mapVC() setObject:bar forKey:self];
    }
    return bar;
}

- (UINavigationBar *)alone_barNavigationBar {
    FLAloneNavigationBar *bar = self.aloneBarNavigationBar;
    return bar;
}

- (UINavigationItem *)alone_navigationItem {
    FLAloneNavigationBar *bar = self.aloneBarNavigationBar;
    return bar.topItem;
}
@end
