//
//  QDFilterView.h

//  Created by mac on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "QDFilterItemCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDFilterView : UIView

@property(nonatomic, strong, readonly) NSArray<QDFilterRow *> *filterRows;
@property(nonatomic, copy) void(^beforeSubmitBlock)(void);
@property(nonatomic, copy) void(^filterBlock)(void);
@property(nonatomic, copy) void(^changeBlock)(QDFilterRow *row);
@property(nonatomic, copy) void(^showBlock)(void);
@property(nonatomic, copy) void(^hideBlock)(void);

- (void)setupFilterRows:(NSArray<QDFilterRow *> *)filterRows;
- (void)hideSelf;
- (void)show;
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
