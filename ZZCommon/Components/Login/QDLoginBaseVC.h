//
//  QDLoginBaseVC.h
//  jzjx
//
//  Created by mac on 2022/8/25.
//

#import "QDCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDLoginBaseVC : QDCommonViewController

@property(nonatomic, copy) void(^loginSuccess)(void);
@property(nonatomic, assign) BOOL isShowingLoadingView;

- (void)showLoginLoading;
- (void)hideLoginLoading;

@end

NS_ASSUME_NONNULL_END
