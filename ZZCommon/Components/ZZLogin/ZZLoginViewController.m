//
//  ZZLoginViewController.m

//  Created by westMac on 2021/11/22.
//

#import "ZZLoginViewController.h"
#import "ZZTabBarViewController.h"
#import "ProtocolAndPrivacyView.h"
#import "ZZPasswordLoginViewController.h"

@interface ZZLoginViewController ()

@end

@implementation ZZLoginViewController

- (BOOL)preferredNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - checkAutologin
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    if (accessToken) {
        [ComUserHelper shareInstance].accessToken = accessToken;
        
        // 验证token是否过期
        [self showLoginLoading];
        [ComUserHelper enter:accessToken success:^(UserInfo * _Nullable userInfo) {
            [self hideLoginLoading];
            self.loginSuccess();
        } failure:^(ResponseModel * _Nullable responseModel) {
            [self hideLoginLoading];
            [QDUITips showError:responseModel.msg inView:self.view];
            if (responseModel.code == 401 || responseModel.code == 424) {
                [ComUserHelper clearLoginCache];
            }
            NSLog(@"accessToken验证失败！");
        }];
    } else {
        NSLog(@"accessToken为空！");
    }
    
    [self changeWay:0 animation:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabBarController hideTabBar];
}

- (void)initSubviews {
    [super initSubviews];

}

- (void)passwordLogin {
    [self changeWay:0 animation:YES];
}

- (void)changeWay:(int)way animation:(BOOL)animation {
    __weak __typeof(self)weakSelf = self;
    if (way == 0) {
        ZZPasswordLoginViewController *vc = [[ZZPasswordLoginViewController alloc] init];
        vc.changeWayBlock = ^(int way) {
            [weakSelf changeWay:way animation:NO];
        };
        vc.loginSuccess = self.loginSuccess;
        vc.isShowingLoadingView = self.isShowingLoadingView;
        [self.navigationController pushViewController:vc animated:animation];
    }
}

@end
