//
//  QDLoginBaseVC.m
//  jzjx
//
//  Created by mac on 2022/8/25.
//

#import "QDLoginBaseVC.h"

@interface QDLoginBaseVC ()

@end

@implementation QDLoginBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showLoginLoading {
    self.isShowingLoadingView = YES;
    [QDUITips showLoading:@"登录中..." inView:self.view];
}

- (void)hideLoginLoading {
    self.isShowingLoadingView = NO;
    [QDUITips hideAllTipsInView:self.view];
    
    UIViewController *topVC = QMUIHelper.visibleViewController;
    if (topVC != self && [topVC isKindOfClass:[QDLoginBaseVC class]]) {
        [((QDLoginBaseVC *)topVC) hideLoginLoading];
    }
}

@end
