//
//  ZZFormRowTableViewCell.h
//  jzjx
//
//  Created by Ethan on 2022/9/28.
//

#import <UIKit/UIKit.h>
#import "ZZFormRowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZFormRowTableViewCell : UITableViewCell

@property(nonatomic, strong) UIView *selectedMaskView;

- (void)updateWithRowModel:(ZZFormRowModel *)rowModel;
- (void)updateWithRowModel:(ZZFormRowModel *)rowModel toItemIndex:(NSInteger)toItemIndex;

@property(nonatomic, copy) void(^tapCellBlock)(ZZFormRowModel *rowModel, NSInteger column, QMUIButton *sender);

@end

NS_ASSUME_NONNULL_END
