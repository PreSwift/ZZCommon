//
//  ZZTabBarViewController.h
//

#import <QMUIKit/QMUIKit.h>

@interface ZZTabBarViewController : QMUITabBarViewController

- (NSArray<UIViewController *> *)getRootMain;

@end

@interface UITabBarController (ShowOrHide)

- (void)hideTabBar;
- (void)showTabBar;

@end
