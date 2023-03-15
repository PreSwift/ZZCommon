//
//  QDUITips.h

//  Created by mac on 2022/7/12.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDUITips : QMUITips

/// 类方法：主要用在局部一次性使用的场景，hide之后会自动removeFromSuperView

+ (QDUITips *)createTipsToView:(UIView *)view;

+ (QDUITips *)showLoadingInView:(UIView *)view;
+ (QDUITips *)showLoading:(nullable NSString *)text inView:(UIView *)view;
+ (QDUITips *)showLoadingInView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (QDUITips *)showLoading:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (QDUITips *)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (QDUITips *)showLoading:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (QDUITips *)showWithText:(nullable NSString *)text;
+ (QDUITips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (QDUITips *)showWithText:(nullable NSString *)text inView:(UIView *)view;
+ (QDUITips *)showWithText:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (QDUITips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (QDUITips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (QDUITips *)showSucceed:(nullable NSString *)text;
+ (QDUITips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (QDUITips *)showSucceed:(nullable NSString *)text inView:(UIView *)view;
+ (QDUITips *)showSucceed:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (QDUITips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (QDUITips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (QDUITips *)showError:(nullable NSString *)text;
+ (QDUITips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (QDUITips *)showError:(nullable NSString *)text inView:(UIView *)view;
+ (QDUITips *)showError:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (QDUITips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (QDUITips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

+ (QDUITips *)showInfo:(nullable NSString *)text;
+ (QDUITips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText;
+ (QDUITips *)showInfo:(nullable NSString *)text inView:(UIView *)view;
+ (QDUITips *)showInfo:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;
+ (QDUITips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view;
+ (QDUITips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

/// 隐藏 tips
+ (void)hideAllTipsInView:(UIView *)view;
+ (void)hideAllTips;

@end

NS_ASSUME_NONNULL_END
