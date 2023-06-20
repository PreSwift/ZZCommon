//
//  UIScrollView+RequestPageExtension.h

//  Created by westMac on 2021/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 框架分页通用处理方式
 */
@interface UIScrollView (RequestPageExtension)

@property(nonatomic, assign, readonly) int page;

/**
 同时添加下拉刷新和上拉加载更多
 */
- (void)addRefreshView:(BOOL)refreshFirst refreshBlock:(void(^_Nonnull)(void))refreshBlock;

/**
 同时添加下拉刷新
 */
- (void)addRefreshViewWithOutFooter:(BOOL)refreshFirst refreshBlock:(void(^_Nonnull)(void))refreshBlock;

/**
 重置分页为1
 */
- (void)resetPage;

/**
 开始刷新
 */
- (void)begainRefreshing;

/**
 结束刷新
 */
- (void)endRefreshing:(BOOL)noMoreData;

/**
 自动处理分页数据获取成功
 */
- (void)handleSuccessWithSection:(NSInteger)section data:(NSMutableArray *_Nonnull)originalData addData:(NSArray * _Nullable)additionalData total:(NSInteger)total;
- (void)handleSuccessWithSection:(NSInteger)section data:(NSMutableArray *_Nonnull)originalData currentRow:(NSInteger)currentRow addData:(NSArray *_Nullable)additionalData total:(NSInteger)total;

/**
 自动处理分页数据获取失败
 isEmpty: 是否为空
 */
- (void)handleFail:(BOOL)isEmpty responseMsg:(NSString *)responseMsg;

@end

NS_ASSUME_NONNULL_END
