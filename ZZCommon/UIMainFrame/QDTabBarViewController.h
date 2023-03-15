//
//  QDTabBarViewController.h
//  qmuidemo
//
//  Created by QMUI Team on 15/6/2.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//


@interface QDTabBarViewController : QMUITabBarViewController

- (void)changeRootToLogin;

- (NSArray<UIViewController *> *)getRootMain;

@end

@interface UITabBarController (ShowOrHide)

- (void)hideTabBar;

- (void)showTabBar;

@end
