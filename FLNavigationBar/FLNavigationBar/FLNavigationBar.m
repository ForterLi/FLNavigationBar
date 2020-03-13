//
//  yqNavigationBar.m
//  yqBaseNavigationBar
//
//  Created by 李永强 on 2019/4/18.
//  Copyright © 2019 李永强. All rights reserved.
//


#import "FLNavigationBar.h"
#import "UIScreen+FLAdd.h"
#import "UINavigationItem+FLBar.h"
#import "FLNavigationBarPrivate.h"
#import <objc/runtime.h>


@interface FLNavigationBar ()

@property (nonatomic, assign) FLBarStyle barCustomStyle;
@property (nonatomic, assign) FLBlurEffectStyle barBlurEffectStyle;
@property (nonatomic, strong) UIColor *barLineColor;
@property (nonatomic, strong) UIColor *barBackgroundColor;

@property (nonatomic, weak)  UIViewController *currentViewController;

@end

@implementation FLNavigationBar {
    //  system view
    __weak UIView *_systemBackgroundView;
    __weak UIView *_systemNavigationBarContentView;
    
    // custom view
    __weak UIView *_customContainerView;
    __weak UIView *_customBackgroundView;
    __weak UIVisualEffectView *_customVisualEffectView;
    __weak UIView *_customLineShadowView;
    
    BOOL _barUserInteractionEnabled;
    NSLayoutConstraint *_constraintHeight;
    
    // current style
    UIBlurEffectStyle _currentBarBlurEffectStyle;
    
    // bar view styls
    BOOL _tempBackgroundViewAlpha;
    UIColor *_tempBackgroundViewColor;
    BOOL _tempLineShadowViewAlpha;
    UIColor *_tempLineShadowViewColor;
    BOOL _tempVisualEffectViewAlpha;
    UIBlurEffectStyle _tempBarBlurEffectStyle;
    BOOL _tempHidesBackButton;
    BOOL _tempBarUserInteractionEnabled;
    
    // Constant
    UIColor *_clearColor;
    UIColor *_whiteAlphaZero;
    
    // Default
    UIColor *_defaultBarColor;
    UIColor *_defaultLintColor;
    FLBlurEffectStyle _defaultBlurEffectStyle;
}


#pragma mark - Class Public Methods

#pragma mark - Instance Public Methods
// MARK: update bar style
- (void)updateNavigation:(id<UIViewControllerTransitionCoordinatorContext>)context {
    UIViewController *toVC  = [context viewControllerForKey:UITransitionContextToViewControllerKey];
    if (!toVC)return;
    self.currentViewController = toVC;
    [self barStyleWithItem:toVC.navigationItem];
}

// MARK: end update bar style
- (void)endNavigation:(UIViewController *)currentVC {
    if (!currentVC)return;
    self.currentViewController = currentVC;
    [self barStyleWithItem:currentVC.navigationItem];
}

- (void)barStyleUpdate {
    if (!self.topItem)return;
    [self barStyleWithItem:self.topItem];
}

#pragma mark - Life Cycle
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self barSetupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self barSetupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self gainSystemBackgroundView];
    [self barGainASystemView];
    [self sendSubviewToBack:_customContainerView];
}

#pragma mark - Event Reponse
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (_barUserInteractionEnabled == NO) {
        return nil;
    }
    return [super hitTest:point withEvent:event];
}

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    if ([self allowBackAction]) {
        return [super popNavigationItemAnimated:animated];
    }
    return nil;
}

#pragma mark - Notification
#pragma mark - Instance Private Methods
- (void)barSetupViews {
    _clearColor = UIColor.clearColor;
    _whiteAlphaZero = [UIColor.whiteColor colorWithAlphaComponent:0];
    _barUserInteractionEnabled = YES;
    _defaultBarColor = [UIColor.whiteColor colorWithAlphaComponent:0];
    _defaultLintColor = [UIColor colorWithRed:216./255. green:216./255. blue:216./255. alpha:1];
    _defaultBlurEffectStyle = FLBlurEffectStyleLight;
    
    if (@available(iOS 13.0, *)) {
        _defaultLintColor = [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
             switch (traitCollection.userInterfaceStyle) {
                 case UIUserInterfaceStyleDark:
                     return [UIColor.whiteColor colorWithAlphaComponent:0];
                 case UIUserInterfaceStyleLight:
                 default:
                     return [UIColor colorWithRed:216./255. green:216./255. blue:216./255. alpha:1];
             }
         }];
        _defaultBlurEffectStyle = FLBlurEffectStyleRegular;
    }
    
    _barCustomStyle = FLBarStyleDefault;
    _barLineColor = _defaultLintColor;
    _barBackgroundColor = _defaultBarColor;
    _barBlurEffectStyle = _defaultBlurEffectStyle;
    _currentBarBlurEffectStyle = [self transitionBlurEffectStyle:_barBlurEffectStyle];

    /// customContainerView
    UIView *customContainerView = [[UIView alloc] init];
    customContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    customContainerView.backgroundColor = UIColor.clearColor;
    customContainerView.userInteractionEnabled = NO;
    [self addSubview:customContainerView];
    _customContainerView = customContainerView;

    /// customVisualEffectView
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:[self transitionBlurEffectStyle:_barBlurEffectStyle]];
    UIVisualEffectView *customVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    customVisualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [customContainerView addSubview:customVisualEffectView];
    _customVisualEffectView = customVisualEffectView;
    NSArray *contraintsVisualEffectViewH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[customVisualEffectView]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"customVisualEffectView":customVisualEffectView}];
    NSArray *contraintVisualEffectViewV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[customVisualEffectView(==customContainerView)]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"customVisualEffectView":customVisualEffectView,@"customContainerView":customContainerView}];
    [self addConstraints:contraintsVisualEffectViewH];
    [self addConstraints:contraintVisualEffectViewV];
    
    /// customBackgroundView
    UIView *customBackgroundView = [[UIView alloc] init];
    customBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    customBackgroundView.backgroundColor = _barBackgroundColor;
    customBackgroundView.alpha = YES;
    [customContainerView addSubview:customBackgroundView];
    _customBackgroundView = customBackgroundView;
    NSArray *contraintsCustomBackgroundViewH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[customBackgroundView]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"customBackgroundView":customBackgroundView}];
    NSArray *contraintsCustomBackgroundViewV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[customBackgroundView(==customContainerView)]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"customBackgroundView":customBackgroundView,@"customContainerView":customContainerView}];
    [self addConstraints:contraintsCustomBackgroundViewH];
    [self addConstraints:contraintsCustomBackgroundViewV];
    
    /// customLineShadowView
    UIView *lineView = [[UIView alloc] init];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    lineView.backgroundColor = _barLineColor;
    [customContainerView addSubview:lineView];
    _customLineShadowView = lineView;
    NSArray *contraintsCustomLineShadowViewH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[customLineShadowView]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:@{@"customLineShadowView":lineView}];
    NSArray *contraintsCustomLineShadowViewV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[customLineShadowView(0.5)]-mege-|" options:NSLayoutFormatAlignAllBottom metrics:@{@"mege":@(-0.5)} views:@{@"customLineShadowView":lineView}];
    [self addConstraints:contraintsCustomLineShadowViewH];
    [self addConstraints:contraintsCustomLineShadowViewV];

    [self setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = UIImage.new;
}

// MARK: reset styles
- (void)resetCustomViewStyle {
    _tempBackgroundViewAlpha = 0;
    _tempBackgroundViewColor = _whiteAlphaZero;
    _tempLineShadowViewAlpha = _tempBackgroundViewAlpha;
    _tempLineShadowViewColor = _tempBackgroundViewColor;
    _tempVisualEffectViewAlpha = _tempBackgroundViewAlpha;
    _tempHidesBackButton = NO;
    _tempBarUserInteractionEnabled = YES;
    _tempBarBlurEffectStyle = UIBlurEffectStyleLight;
}


// MARK: systemBackgroundView
- (void)gainSystemBackgroundView {
    if (_systemBackgroundView == nil) {
        for (UIView *aView in self.subviews) {
            if ([aView isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {

                _systemBackgroundView = aView;
                NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:_customContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_systemBackgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
                NSLayoutConstraint *constraintBottom = [NSLayoutConstraint constraintWithItem:_customContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];

                 NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:_customContainerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];

                 NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:_customContainerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
                 [self addConstraints:@[constraintTop,constraintLeft,constraintRight,constraintBottom]];
            }
        }
    }
}

// MARK: layoutMargins 设置
- (void)barGainASystemView {
    if (@available(iOS 11.0, *)) {
        if (!_systemNavigationBarContentView) {
            for (UIView *subView in self.subviews) {
                if ([NSStringFromClass([subView class]) isEqualToString:@"_UINavigationBarContentView"]) {
                    _systemNavigationBarContentView = subView;
                }
            }
        }
        if (_systemNavigationBarContentView) {
   
        }
    }
}

// MARK: bar 样式 item
- (void)barStyleWithItem:(UINavigationItem *)item {
    FLBarStyle barStyle = item.yq_barStyle;
    UIColor *barColor = item.yq_barBackgroundColor;
    UIColor *lineColor = item.yq_barLineColor;
    FLBlurEffectStyle barEffectStyle = item.yq_barBlurEffectStyle;
    if (barStyle == FLBarStyleNone) {
        barStyle =  _barCustomStyle;
        barColor = barColor ?:_barBackgroundColor;
        lineColor = lineColor ?: _barLineColor;
        barEffectStyle = barEffectStyle ?: _barBlurEffectStyle;
    }
    [self resetCustomViewStyle];
    switch (barStyle) {
        case FLBarStyleColor:
            _tempBackgroundViewAlpha = 1;
            _tempBackgroundViewColor = [self transitionBackgroundColor:barColor];
            _tempLineShadowViewAlpha = 1;
            _tempLineShadowViewColor = [self transitionLineShadowColor:lineColor];
            break;
        case FLBarStyleTransparent:
            break;
        case FLBarStyleHidden:
            _tempHidesBackButton = YES;
            _tempBarUserInteractionEnabled = NO;
            break;
        case FLBarStyleTranslucent:
            _tempVisualEffectViewAlpha = 1;
            _tempLineShadowViewAlpha = 1;
            _tempLineShadowViewColor = [self transitionLineShadowColor:lineColor];
            _tempBarBlurEffectStyle = [self transitionBlurEffectStyle:barEffectStyle];
            break;
        case FLBarStyleDefault:
        default:
            _tempVisualEffectViewAlpha = 1;
            _tempLineShadowViewAlpha = 1;
            _tempLineShadowViewColor = _defaultLintColor;
            _tempBarBlurEffectStyle = [self transitionBlurEffectStyle:_defaultBlurEffectStyle];
            break;
    }
    _customBackgroundView.backgroundColor = _tempBackgroundViewColor;
    _customBackgroundView.alpha = _tempBackgroundViewAlpha;
    _customLineShadowView.backgroundColor = _tempLineShadowViewColor;
    _customLineShadowView.alpha = _tempLineShadowViewAlpha;
    _customVisualEffectView.alpha = _tempVisualEffectViewAlpha;
    item.hidesBackButton = _tempHidesBackButton;
    _barUserInteractionEnabled = _tempBarUserInteractionEnabled;
    
    if (item.yq_customHidesBackButton == NO ) {
        if (item.yq_barStyle == FLBarStyleHidden) {
            item.hidesBackButton = YES;
        }else{
            item.hidesBackButton = NO;
        }
     }
    if (_tempBarBlurEffectStyle != _currentBarBlurEffectStyle) {
        _customVisualEffectView.effect = [UIBlurEffect effectWithStyle:_tempBarBlurEffectStyle];
        _currentBarBlurEffectStyle = _tempBarBlurEffectStyle;
    }
}

- (BOOL)allowBackAction {
    BOOL isBack = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([self.currentViewController respondsToSelector:@selector(barNavigationShouldPopOnBackButton)]) {
        char resultChar = (char)[self.currentViewController performSelector:@selector(barNavigationShouldPopOnBackButton)];
        isBack = [[NSNumber numberWithChar:resultChar] boolValue];
    }
#pragma clang diagnostic pop
    return isBack;
}

#pragma mark - Class Private Methods
#pragma mark - Modules
#pragma mark transition color
- (UIColor *)transitionBackgroundColor:(UIColor *)color {
    if (color == nil) {
        return _barBackgroundColor;
    }
    return [self transitionColor:color];
}


- (UIColor *)transitionLineShadowColor:(UIColor *)color {
    if (color == nil) {
        return _barLineColor;
    }
    return [self transitionColor:color];
}

- (UIColor *)transitionColor:(UIColor *)color {
    if (CGColorEqualToColor(color.CGColor, _clearColor.CGColor)) {
        return _whiteAlphaZero;
    }
    return color;
}

- (UIBlurEffectStyle)transitionBlurEffectStyle:(FLBlurEffectStyle)style {
    switch (style) {
        case FLBlurEffectStyleExtraLight:
            return UIBlurEffectStyleExtraLight;
        case FLBlurEffectStyleLight:
            return UIBlurEffectStyleLight;
        case FLBlurEffectStyleDark:
            return UIBlurEffectStyleDark;
        default:
            if (@available(iOS 11.0, *)) {
                switch (style) {
                    case FLBlurEffectStyleRegular:
                        return UIBlurEffectStyleRegular;
                    case FLBlurEffectStyleProminent:
                        return UIBlurEffectStyleProminent;
                    default:
                        break;
                }
            }
            break;
    }
    return UIBlurEffectStyleLight;
}

#pragma mark - Setters
- (void)setBarCustomStyle:(FLBarStyle)barCustomStyle {
    _barCustomStyle = barCustomStyle;
}

- (void)setBarLineColor:(UIColor *)barLineColor {
    _barLineColor = barLineColor;
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    _barBackgroundColor = barBackgroundColor;
}

- (void)setBarBlurEffectStyle:(FLBlurEffectStyle)barBlurEffectStyle {
    _barBlurEffectStyle = barBlurEffectStyle;
}

#pragma mark - Getters
- (UIView *)systemBackgroundView {
    return _systemBackgroundView;
}

- (UIVisualEffectView *)customVisualEffectView {
    return _customVisualEffectView;
}

- (UIView *)customBackgroundView {
    return _customBackgroundView;
}

- (UIView *)customLineShadowView {
    return _customLineShadowView;
}

- (void)setTranslucent:(BOOL)translucent{}

@end


void yq_swizzle(Class oldClass, NSString *oldSelector, Class newClass) {
    NSString *newSelector = [NSString stringWithFormat:@"yq_%@", oldSelector];
    Method old = class_getInstanceMethod(oldClass, NSSelectorFromString(oldSelector));
    Method new = class_getInstanceMethod(newClass, NSSelectorFromString(newSelector));
    method_exchangeImplementations(old, new);
}
@implementation NSObject (YQFixSpace)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            NSArray<NSDictionary<NSString *,NSString *> *> *oriSels = @[
                @{
                    @"cls":@"_UINavigationBarContentView",
                    @"sel":@"_updateLayoutMarginsForLayout:"
                }
            ];
            [oriSels enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                yq_swizzle(NSClassFromString(obj[@"cls"]), obj[@"sel"], FLNavigationBar.class);
            }];
        }
    });
}


/*
 *  11.0
 
 
 @{
    @"cls":@"_UINavigationBarContentView",
    @"sel":@"__backButtonAction:"
 }
 
 -(void)yq___backButtonAction:(id)arg1 {
    @try {
        if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentView")])return;
        UIView *barContentView = (UIView *)self;
        if (![barContentView.superview isKindOfClass:FLNavigationBar.class]){
            [self yq___backButtonAction:arg1];
            return;
        }
        FLNavigationBar *bar = (FLNavigationBar *)(barContentView.superview);
        if ([bar allowBackAction]) {
            [self yq___backButtonAction:arg1];
        }
    } @catch (NSException *exception) {
        [self yq___backButtonAction:arg1];
    } @finally {}
}
*/
/**
 *  设置返回按钮边距   11.0
 *  @{
 *    @"cls":@"_UINavigationBarContentView",
 *    @"sel":@"backButtonMargin"
 *   }
 *
 *   - (double)yq_backButtonMargin {
 *      return 100;
 *   }
 */

/**
 *
 *    for (UIView *sub in barContentView.subviews) {
         if ([sub isMemberOfClass: NSClassFromString(@"_UIButtonBarStackView")]) {
             if (@available(iOS 9.0, *)) {
                 UIStackView *stack = (UIStackView *)sub;
                 stack.distribution = UIStackViewDistributionFillProportionally;
             }
         }
     }
 *
 *
 *
 */

-(void)yq__updateLayoutMarginsForLayout:(id)arg1 {
    if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentView")])return;
    UIView *barContentView = (UIView *)self;
    if (![barContentView.superview isKindOfClass:FLNavigationBar.class])return;
    @try {
        [arg1 setValue:@(UIEdgeInsetsZero) forKey:@"_layoutMargins"];
    } @catch (NSException *exception) {
        [self yq__updateLayoutMarginsForLayout:arg1];
    } @finally {}
}

@end
