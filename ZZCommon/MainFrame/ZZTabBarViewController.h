//
//  ZZTabBarViewController.h
//


@interface ZZTabBarViewController : QMUITabBarViewController

- (void)changeRootToLogin;

- (NSArray<UIViewController *> *)getRootMain;

@end

@interface UITabBarController (ShowOrHide)

- (void)hideTabBar;

- (void)showTabBar;

@end
