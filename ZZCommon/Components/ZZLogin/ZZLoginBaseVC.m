//
//  ZZLoginBaseVC.m

//  Created by mac on 2022/8/25.
//

#import "ZZLoginBaseVC.h"
#import "QDUITips.h"

@interface ZZLoginBaseVC ()

@end

@implementation ZZLoginBaseVC

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
    if (topVC != self && [topVC isKindOfClass:[ZZLoginBaseVC class]]) {
        [((ZZLoginBaseVC *)topVC) hideLoginLoading];
    }
}

@end
