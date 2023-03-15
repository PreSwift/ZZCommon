//
//  ZZFormRowView.h

//  Created by mac on 2023/2/13.
//

#import <UIKit/UIKit.h>
#import "ZZFormRowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZFormRowView : UIView

- (void)updateUIWith:(ZZFormRowModel *)rowModel;
- (void)updateUIWith:(ZZFormRowModel *)rowModel toItemIndex:(NSInteger)toItemIndex;

- (void)updateUIWithItem:(ZZFormItemModel *)itemModel atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
