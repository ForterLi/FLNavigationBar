//
//  FLBaseViewController.m
//  SYCBaseModule
//
//  Created by 李永强 on 2019/4/19.
//  Copyright © 2019 李永强. All rights reserved.
//

#import "FLBaseViewController.h"


NSString *const FLBaseViewControllerWillAppear = @"FLBaseViewControllerWillAppear";
NSString *const FLBaseViewControllerDidAppear = @"FLBaseViewControllerDidAppear";
NSString *const FLBaseViewControllerWillDisappear = @"FLBaseViewControllerWillDisappear";
NSString *const FLBaseViewControllerDidDisappear = @"FLBaseViewControllerDidDisappear";

@interface FLBaseViewController ()

@end

@implementation FLBaseViewController

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)loadView {
    [super loadView];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
