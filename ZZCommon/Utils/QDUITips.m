//
//  QDUITips.m
//  jzjx
//
//  Created by mac on 2022/7/12.
//

#import "QDUITips.h"

@implementation QDUITips

- (instancetype)initWithView:(UIView *)view
{
    self = [super initWithView:view];
    if (self) {
        self.userInteractionEnabled = NO;
        self.maskView.userInteractionEnabled = NO;
        [QDUITips hideAllTipsInView:view];
    }
    return self;
}

+ (QDUITips *)showLoadingInView:(UIView *)view {
    return [self showLoading:nil detailText:nil inView:view hideAfterDelay:0];
}

+ (QDUITips *)showLoading:(NSString *)text inView:(UIView *)view {
    return [self showLoading:text detailText:nil inView:view hideAfterDelay:0];
}

+ (QDUITips *)showLoadingInView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showLoading:nil detailText:nil inView:view hideAfterDelay:delay];
}

+ (QDUITips *)showLoading:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showLoading:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (QDUITips *)showLoading:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showLoading:text detailText:detailText inView:view hideAfterDelay:0];
}

+ (QDUITips *)showLoading:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    if (!view) {
        return nil;
    }
    QDUITips *tips = [self createTipsToView:view];
    tips.userInteractionEnabled = YES;
    tips.maskView.userInteractionEnabled = YES;
    [tips showLoading:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (QDUITips *)showWithText:(nullable NSString *)text {
    return [self showWithText:text detailText:nil inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showWithText:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showWithText:text detailText:detailText inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showWithText:(NSString *)text inView:(UIView *)view {
    return [self showWithText:text detailText:nil inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showWithText:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showWithText:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (QDUITips *)showWithText:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showWithText:text detailText:detailText inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showWithText:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    if ((!text && !detailText) || !view) {
        return nil;
    }
    QDUITips *tips = [self createTipsToView:view];
    [tips showWithText:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (QDUITips *)showSucceed:(nullable NSString *)text {
    return [self showSucceed:text detailText:nil inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showSucceed:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showSucceed:text detailText:detailText inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showSucceed:(NSString *)text inView:(UIView *)view {
    return [self showSucceed:text detailText:nil inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showSucceed:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showSucceed:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (QDUITips *)showSucceed:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showSucceed:text detailText:detailText inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showSucceed:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    if ((!text && !detailText) || !view) {
        return nil;
    }
    QDUITips *tips = [self createTipsToView:view];
    [tips showSucceed:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (QDUITips *)showError:(nullable NSString *)text {
    return [self showError:text detailText:nil inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showError:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showError:text detailText:detailText inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showError:(NSString *)text inView:(UIView *)view {
    return [self showError:text detailText:nil inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showError:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showError:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (QDUITips *)showError:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showError:text detailText:detailText inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showError:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    if ((!text && !detailText) || !view) {
        return nil;
    }
    QDUITips *tips = [self createTipsToView:view];
    [tips showError:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (QDUITips *)showInfo:(nullable NSString *)text {
    return [self showInfo:text detailText:nil inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showInfo:(nullable NSString *)text detailText:(nullable NSString *)detailText {
    return [self showInfo:text detailText:detailText inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showInfo:(NSString *)text inView:(UIView *)view {
    return [self showInfo:text detailText:nil inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showInfo:(NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    return [self showInfo:text detailText:nil inView:view hideAfterDelay:delay];
}

+ (QDUITips *)showInfo:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view {
    return [self showInfo:text detailText:detailText inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds];
}

+ (QDUITips *)showInfo:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay {
    if ((!text && !detailText) || !view) {
        return nil;
    }
    QDUITips *tips = [self createTipsToView:view];
    [tips showInfo:text detailText:detailText hideAfterDelay:delay];
    return tips;
}

+ (QDUITips *)createTipsToView:(UIView *)view {
    QDUITips *tips = [[QDUITips alloc] initWithView:view];
    [view addSubview:tips];
    tips.removeFromSuperViewWhenHide = YES;
    return tips;
}

+ (void)hideAllTipsInView:(UIView *)view {
    [self hideAllToastInView:view animated:NO];
}

+ (void)hideAllTips {
    [self hideAllToastInView:nil animated:NO];
}

@end
