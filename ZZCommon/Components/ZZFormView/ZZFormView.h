//
//  ZZFormView.h
//  jzjx
//
//  Created by Ethan on 2022/9/28.
//

#import <UIKit/UIKit.h>
#import "ZZFormRowModel.h"
#import "ZZFormRowTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZFormView : UIView

/**
 顶部固定浮动行数，默认0
 */
@property(nonatomic, assign) NSInteger floatTopRowNumber;

/**
 左部固定浮动列数， 默认0
 */
@property(nonatomic, assign) NSInteger floatLeftColumnNumber;

/**
 是否允许滚动
 */
@property(nonatomic, assign) BOOL scrollEnabled;

/**
 点击行回调
 */
@property(nonatomic, copy) void(^tapRowBlock)(NSInteger row);

/**
 点击单元格回调
 */
@property(nonatomic, copy) void(^tapCellBlock)(NSInteger row, NSInteger column, QMUIButton *sender);

/**
 滑动手势结束回调
 */
@property(nonatomic, copy) void(^scrollViewWillEndDraggingBlock)(UIScrollView *scrollView, CGPoint velocity);
/**
 滚动到底部回调
 */
@property(nonatomic, copy) void(^scrollViewDidScrollToBottomBlock)(UIScrollView *scrollView);
/**
 行渲染数据
 */
@property(nonatomic, strong, readonly) NSArray<ZZFormRowModel *> *rows;

/**
 刷新界面数据
 */
- (void)updateWithRows:(NSArray<ZZFormRowModel *> *)rows;

/**滚动到指定行**/
- (void)scrollToRow:(ZZFormRowModel *)row animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
