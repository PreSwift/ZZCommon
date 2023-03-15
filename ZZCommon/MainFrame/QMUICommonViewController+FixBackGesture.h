//
//  QMUICommonViewController+FixBackGesture.h

//  Created by mac on 2022/3/24.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMUICommonViewController (FixBackGesture)

/**
 修复部分页面返回手势失效的问题
 */
- (void)fixGestureGoBack;

@end

NS_ASSUME_NONNULL_END
