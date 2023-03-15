//
//  ZZLoginBaseVC.h

//  Created by mac on 2022/8/25.
//

#import "ZZCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZLoginBaseVC : ZZCommonViewController

@property(nonatomic, copy) void(^loginSuccess)(void);
@property(nonatomic, assign) BOOL isShowingLoadingView;

- (void)showLoginLoading;
- (void)hideLoginLoading;

@end

NS_ASSUME_NONNULL_END
