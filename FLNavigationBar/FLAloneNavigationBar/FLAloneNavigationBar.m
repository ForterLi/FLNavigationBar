//
//  FLAloneNavigationBar.m
//  FLBaseKit
//
//  Created by 李永强 on 2019/8/19.
//  Copyright © 2019 李永强. All rights reserved.
//

#import "FLAloneNavigationBar.h"
#import "FLNavigationBarPrivate.h"
#import "UIScreen+FLAdd.h"

@interface UIView (AloneBar)

- (UIViewController *)aloneViewController;

@end

@interface FLAloneNavigationBar () {
    UIColor *_color;
}

@property(nonatomic, weak) UIViewController *currentViewController;


@end

@implementation FLAloneNavigationBar {
    //  system view
    NSLayoutConstraint *_constraintTop;
    NSLayoutConstraint *_constraintHeight;

    __weak UIView *_currentSuperview;

    NSArray *_barConstraints;
}

#pragma mark - Class Public Methods
#pragma mark - Instance Public Methods
#pragma mark - Life Cycle


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initialize];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(false, @"not xib");
    self = [super initWithCoder:aDecoder];
    [self initialize];
    return self;
}

#pragma mark - Delegate
- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    BOOL isBack = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([self.currentViewController respondsToSelector:@selector(barNavigationShouldPopOnBackButton)]) {
        char resultChar = (char)[self.currentViewController performSelector:@selector(barNavigationShouldPopOnBackButton)];
        isBack = [[NSNumber numberWithChar:resultChar] boolValue];
    }
#pragma clang diagnostic pop
    if (isBack) {
        [self.currentViewController.navigationController popViewControllerAnimated:YES];
    }
    return nil;
}
#pragma mark - Event Reponse
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.currentViewController = self.aloneViewController;
    if (self.superview && self.superview != _currentSuperview) {
        _currentSuperview = self.superview;
        [self addLayoutView];
    }
    [self _updateBarStyle];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self removeLayoutView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _constraintTop.constant = kStatusBarHeighOrientation();
    _constraintHeight.constant = kNavgationBarHeightOrientation();
    if (self.systemBackgroundView) {
        self.systemBackgroundView.frame = CGRectMake(0, -kStatusBarHeighOrientation(), kScreenWidth,kStatusBarHeighOrientation() + kNavgationBarHeightOrientation());
    }
}

#pragma mark - Notification

#pragma mark - Instance Private Methods
// MARK: 初始化
- (void)initialize {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UINavigationItem *backItem = [[UINavigationItem alloc] init];
    backItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self pushNavigationItem:backItem animated:NO];
    UINavigationItem *topItem = [[UINavigationItem alloc] init];
    [self pushNavigationItem:topItem animated:NO];
    _effectStyle = UIBlurEffectStyleExtraLight;
    _barCustomStyle = FLAloneBarStyleDefault;
    self.customVisualEffectView.alpha = 1;
    self.customBackgroundView.alpha = 1;
    self.customLineShadowView.alpha = 1;
    [self _updateBarStyle];
}


// MARK: systemBackgroundView

// MARK: layoutMargins 设置
- (void)addLayoutView {
    if (_barConstraints == nil) {
        if (!self.superview) {
            return;
        }
        NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        _constraintTop = constraintTop;

        NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        _constraintHeight = constraintHeight;

        NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];

        NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        _barConstraints = @[constraintLeft,constraintRight,constraintTop,constraintHeight];
    }
    [self.superview addConstraints:_barConstraints];
}

- (void)removeLayoutView {
    if (self.superview == nil && _barConstraints && _currentSuperview) {
        [self.superview removeConstraints:_barConstraints];
        _currentSuperview = nil;
    }
}

- (void)_updateBarStyle {
    switch (_barCustomStyle) {
        case FLAloneBarStyleColor:
            if (self.customVisualEffectView.isHidden == NO) self.customVisualEffectView.hidden = YES;
            if (self.customBackgroundView.isHidden == YES) self.customBackgroundView.hidden = NO;
            break;
        case FLAloneBarStyleTransparent:
            if (self.customVisualEffectView.isHidden == NO) self.customVisualEffectView.hidden = YES;
            if (self.customBackgroundView.isHidden == NO) self.customBackgroundView.hidden = YES;
            break;
        case FLAloneBarStyleDefault:
        default:
            if (self.customVisualEffectView.isHidden == YES) self.customVisualEffectView.hidden = NO;
            if (self.customBackgroundView.isHidden == NO) self.customBackgroundView.hidden = YES;
            break;
    }
    self.customBackgroundView.backgroundColor = _color;
    self.customLineShadowView.backgroundColor = _lineShadowColor;
    self.customVisualEffectView.effect = [UIBlurEffect effectWithStyle:_effectStyle];
}


#pragma mark - Class Private Methods
#pragma mark - Modules
- (UIColor *)backgroundColor {
    return _color;
}

#pragma mark - Setters
- (void)setBarCustomStyle:(FLAloneBarStyle)barCustomStyle {
    _barCustomStyle = barCustomStyle;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _color = backgroundColor;
    [self _updateBarStyle];
}

- (void)setLineShadowColor:(UIColor *)lineShadowColor {
    _lineShadowColor = lineShadowColor;
    [self _updateBarStyle];
}

- (void)setEffectStyle:(UIBlurEffectStyle)effectStyle {
    _effectStyle = effectStyle;
    [self _updateBarStyle];
}

@end



@implementation  UIView (AloneBar)

- (UIViewController *)aloneViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
