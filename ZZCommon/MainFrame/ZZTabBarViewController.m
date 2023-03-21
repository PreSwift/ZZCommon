//
//  ZZTabBarViewController.m
//

#import "ZZTabBarViewController.h"
#import "ZZWelcomeViewController.h"
#import "ZZNavigationController.h"
#import "NSBundle+Extension.h"

@interface ZZTabBarViewController ()

@end

@implementation ZZTabBarViewController

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
