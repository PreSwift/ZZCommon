//
//  ZZFilterView.h

//  Created by mac on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "ZZFilterItemCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZFilterView : UIView

@property(nonatomic, strong, readonly) NSArray<ZZFilterRow *> *filterRows;
@property(nonatomic, copy) void(^beforeSubmitBlock)(void);
@property(nonatomic, copy) void(^filterBlock)(void);
@property(nonatomic, copy) void(^changeBlock)(ZZFilterRow *row);
@property(nonatomic, copy) void(^showBlock)(void);
@property(nonatomic, copy) void(^hideBlock)(void);

- (void)setupFilterRows:(NSArray<ZZFilterRow *> *)filterRows;
- (void)hideSelf;
- (void)show;
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
