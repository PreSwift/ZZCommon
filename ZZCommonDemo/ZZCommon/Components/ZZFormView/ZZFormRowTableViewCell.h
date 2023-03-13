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

- (void)updateWithRowModel:(ZZFormRowModel *)rowModel;
- (void)updateWithRowModel:(ZZFormRowModel *)rowModel toItemIndex:(NSInteger)toItemIndex;

@end

NS_ASSUME_NONNULL_END
