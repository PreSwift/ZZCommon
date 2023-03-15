//
//  QMUICommonViewController+Search.h

//  Created by mac on 2022/3/24.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMUICommonViewController (Search)

/**
 搜索关键词
 */
@property(nonatomic, strong) NSString *keyword;
/**
 搜索回调，可在此回调用调用Api请求
 */
@property(nonatomic, copy) void(^searchBlock)(void);

/**
 创建导航栏搜索按钮以及搜索框
 */
- (UIBarButtonItem *)makeSearchButtonItem;

@end

NS_ASSUME_NONNULL_END
