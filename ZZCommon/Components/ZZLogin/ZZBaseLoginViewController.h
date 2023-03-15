//
//  ZZBaseLoginViewController.h

//  Created by mac on 2022/8/24.
//

#import "ZZLoginBaseVC.h"
#import "ProtocolAndPrivacyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZBaseLoginViewController : ZZLoginBaseVC

@property(nonatomic, strong, readonly) UILabel *titleLabel;
@property(nonatomic, strong, readonly) UILabel *descLabel;
@property(nonatomic, strong, readonly) UIView *contentView;
@property(nonatomic, strong, readonly) QMUIButton *sureBtn;
//@property(nonatomic, strong, readonly) UIButton *otherWayBtn;
//@property(nonatomic, strong, readonly) UIView *otherWayView;
//@property(nonatomic, strong, readonly) ProtocolAndPrivacyView *checkView;
@property(nonatomic, copy) void(^changeWayBlock)(int way);

@property(nonatomic, assign) BOOL isCheck;
@property(nonatomic, copy) void(^checkChangeBlock)(BOOL isCheck);

- (void)login;

@end

NS_ASSUME_NONNULL_END
