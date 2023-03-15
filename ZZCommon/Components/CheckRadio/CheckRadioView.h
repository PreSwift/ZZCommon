//
//  CheckRadioView.h

//  Created by mac on 2022/2/8.
//

#import <UIKit/UIKit.h>
#import "CheckRadioModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckRadioView : UIView

@property(nonatomic, copy) void(^checkBlock)(int singleSelectedIndex);
@property(nonatomic, copy) void(^inputBlock)(int itemIndex, NSString *inputValue);
@property(nonatomic, assign) BOOL allowMutableCheck;
@property(nonatomic, assign) UILayoutConstraintAxis axis;

- (instancetype)initWithItems:(NSArray<CheckRadioModel *> *)items;

- (void)clearInput;
- (void)clearInputWithOutCurrent;

@end

NS_ASSUME_NONNULL_END
