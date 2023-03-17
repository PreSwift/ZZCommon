//
//  ZZTabBarViewController.m
//

#import "ZZTabBarViewController.h"
#import "ZZLoginViewController.h"
#import "ZZWelcomeViewController.h"
#import "ZZNavigationController.h"

@interface ZZTabBarViewController ()

@end

@implementation ZZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self toMain];
}

- (void)changeRootToLogin {
    __weak __typeof(self)weakSelf = self;
    ZZLoginViewController *loginVC = [[ZZLoginViewController alloc] init];
    loginVC.loginSuccess = ^{
        [weakSelf changeRootToMainView];
    };
    // window root controller
    self.viewControllers = @[[[ZZNavigationController alloc] initWithRootViewController:loginVC]];
}

- (void)toMain {
//    NSString *localVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"localVersion"];
//    NSString *currentVersion = [NSBundle mainBundle].appVersion;
//    if (localVersion == nil || [[localVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue] < [[currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue]) {
//    if (localVersion == nil) {
//        [self changeRootToWelcome];
//    } else {
        [self changeRootToLogin];
//    }
//    [self changeRootToMainView];
}

- (void)changeRootToWelcome {
    ZZWelcomeViewController *vc = [[ZZWelcomeViewController alloc] init];
    __weak __typeof(self)weakSelf = self;
    vc.changeVCToMainBlock = ^{
        [weakSelf changeRootToLogin];
    };
    self.viewControllers = @[vc];
}

- (void)changeRootToMainView {
    [self showTabBar];
    self.viewControllers = [self getRootMain];
}

- (NSArray<UIViewController *> *)getRootMain {
    return @[];
}

@end

@implementation UITabBarController (ShowOrHide)

- (void)hideTabBar {
    if (self.tabBar.isHidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBar.frame.size.height);
    [self.tabBar setHidden:YES];
} 

- (void)showTabBar {
    if (self.tabBar.isHidden == NO) {
        return;
    }
    UIView *contentView;
    if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBar.frame.size.height);
    [self.tabBar setHidden:NO];
      
}

@end
