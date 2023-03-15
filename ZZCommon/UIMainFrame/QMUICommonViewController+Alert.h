//
//  QMUICommonViewController+Alert.h
//  jzjx
//
//  Created by mac on 2022/3/29.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMUICommonViewController (Alert)

- (void)showTopAlertWith:(NSString *)title;

- (void)showTopAlertWith:(NSString *)title offset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
