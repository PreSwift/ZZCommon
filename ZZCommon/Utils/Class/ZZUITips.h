//
//  ZZUITips.h

//  Created by mac on 2022/7/12.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZUITips : QMUITips

/// 类方法：主要用在局部一次性使用的场景，hide之后会自动removeFromSuperView

+ (ZZUITips *)createTipsToView:(UIView *)view;

+ (ZZUITips *)showLoadingInView:(UIView *)view;
+ (ZZUITips *)showLoading:(nullable NSString *)text inView:(UIView *)view;
+ (ZZUITips *)showLoadingInView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (ZZUITips *)showLoading:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (ZZUITips *)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (ZZUITips *)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (ZZUITips *)showWithText:(nullable NSString *)text;
+ (ZZUITips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (ZZUITips *)showWithText:(nullable NSString *)text inView:(UIView *)view;
+ (ZZUITips *)showWithText:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (ZZUITips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (ZZUITips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (ZZUITips *)showSucceed:(nullable NSString *)text;
+ (ZZUITips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (ZZUITips *)showSucceed:(nullable NSString *)text inView:(UIView *)view;
+ (ZZUITips *)showSucceed:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (ZZUITips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (ZZUITips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (ZZUITips *)showError:(nullable NSString *)text;
+ (ZZUITips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (ZZUITips *)showError:(nullable NSString *)text inView:(UIView *)view;
+ (ZZUITips *)showError:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (ZZUITips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (ZZUITips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (ZZUITips *)showInfo:(nullable NSString *)text;
+ (ZZUITips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (ZZUITips *)showInfo:(nullable NSString *)text inView:(UIView *)view;
+ (ZZUITips *)showInfo:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (ZZUITips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (ZZUITips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

/// 隐藏 tips
+ (void)hideAllTipsInView:(UIView *)view;
+ (void)hideAllTips;

@end

NS_ASSUME_NONNULL_END
