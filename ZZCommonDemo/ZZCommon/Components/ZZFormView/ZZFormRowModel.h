//
//  ZZFormRowModel.h
//  jzjx
//
//  Created by Ethan on 2022/9/28.
//

#import <Foundation/Foundation.h>
#import "ZZFormItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZFormRowModel : NSObject

/**
 选中效果，默认UITableViewCellSelectionStyleDefault
 */
@property(nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;

/**
 选中背景色，默认nil
 */
@property(nonatomic, strong) UIColor *selectedBackgroundColor;

/**
 行高度，默认最少32，但是会根据内容自动计算
 */
@property(nonatomic, assign, readonly) CGFloat rowHeight;

/**
 是否第一行
 */
@property(nonatomic, assign) BOOL isFirstRow;

/**
 左右边距，上下忽略
 */
@property(nonatomic, assign) UIEdgeInsets padding;

/**
 本行从左往右每一列数据
 */
@property(nonatomic, strong, readonly) NSArray<ZZFormItemModel *> *items;

- (instancetype)initWithItems:(NSArray<ZZFormItemModel *> *)items;

@end

NS_ASSUME_NONNULL_END
