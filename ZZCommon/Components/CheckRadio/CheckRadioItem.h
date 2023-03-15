//
//  CheckRadioItem.h
//  teacher
//
//  Created by mac on 2022/2/8.
//

#import <UIKit/UIKit.h>
#import "CheckRadioModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckRadioItem : UIControl

@property(nonatomic, strong) UIImageView *markImageView;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UITextField *contentTextField;
@property(nonatomic, strong) UILabel *descLabel;

@property(nonatomic, strong) CheckRadioModel *model;
@property(nonatomic, copy) void(^inputBlock)(CheckRadioItem *item, NSString *inputValue);

- (instancetype)initWithModel:(CheckRadioModel *)model;

- (void)clearInput;

@end

NS_ASSUME_NONNULL_END
