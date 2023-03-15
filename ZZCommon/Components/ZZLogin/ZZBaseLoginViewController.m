//
//  ZZBaseLoginViewController.m

//  Created by mac on 2022/8/24.
//

#import "ZZBaseLoginViewController.h"
#import "ZZPasswordLoginViewController.h"

@interface ZZBaseLoginViewController ()

@end

@implementation ZZBaseLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isShowingLoadingView) {
        [self showLoginLoading];
    }
}

- (void)initSubviews {
    [super initSubviews];
    
    _titleLabel = [[UILabel alloc] initForAutoLayout];
    _titleLabel.textColor = UIColor.qd_titleTextColor;
    _titleLabel.font = CodeFontMake(SS(24));
    [self.view addSubview:_titleLabel];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:DEVICE_HEIGHT / 5];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(30)];
    
    _descLabel = [[UILabel alloc] initForAutoLayout];
    _descLabel.textColor = UIColor.qd_descriptionTextColor;
    _descLabel.font = CodeFontMake(SS(12));
    [self.view addSubview:_descLabel];
    [_descLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:SS(12)];
    [_descLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLabel];
    
    _contentView = [[UIView alloc] initForAutoLayout];
    [self.view addSubview:_contentView];
    [_contentView autoPinEdge:ALEdgeTop  toEdge:ALEdgeBottom ofView:_descLabel withOffset:SS(40)];
    [_contentView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_contentView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    _sureBtn = [[QMUIButton alloc] initForAutoLayout];
    [_sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    _sureBtn.enabled = NO;
    _sureBtn.titleLabel.font = CodeMediumFontMake(SS(16));
    _sureBtn.backgroundColor = UIColor.qd_tintColor;
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    _sureBtn.layer.shadowColor = UIColor.qd_tintColor.CGColor;
    _sureBtn.layer.shadowRadius = DefaultCornerRadius;
    _sureBtn.layer.shadowOpacity = DefaultShadowOpacity;
    _sureBtn.layer.shadowOffset = DefaultShadowOffset;
    [_sureBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    [_sureBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_sureBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(30)];
    [_sureBtn autoSetDimension:ALDimensionHeight toSize:SS(41)];
    [_sureBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentView withOffset:SS(50)];
    
//    _otherWayBtn = [[UIButton alloc] initForAutoLayout];
//    _otherWayBtn.qmui_outsideEdge = UIEdgeInsetsMake(-5, -10, -5, -10);
//    _otherWayBtn.titleLabel.font = UIFont.qd_mainTextFont;
//    [_otherWayBtn addTarget:self action:@selector(changeWay) forControlEvents:UIControlEventTouchUpInside];
//    [_otherWayBtn setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
//    [self.view addSubview:_otherWayBtn];
//    [_otherWayBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [_otherWayBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_sureBtn withOffset:SS(15)];
//
//    _otherWayView = [[UIView alloc] initForAutoLayout];
//    _otherWayView.hidden = YES;
//
//    UILabel *otherLabel = [[UILabel alloc] initForAutoLayout];
//    otherLabel.text = @"其他登录方式";
//    otherLabel.font = UIFont.qd_mainTextFont;
//    otherLabel.textColor =  UIColor.qd_descriptionTextColor;
//    [_otherWayView addSubview:otherLabel];
//    [otherLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [otherLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
//
//    UIView *line1 = [[UIView alloc] initForAutoLayout];
//    line1.backgroundColor = UIColor.qd_separatorColor;
//    [_otherWayView addSubview:line1];
//    [line1 autoSetDimension:ALDimensionHeight toSize:1];
//    [line1 autoSetDimension:ALDimensionWidth toSize:SS(20)];
//    [line1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:otherLabel];
//    [otherLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:line1 withOffset:SS(9)];
//
//    UIView *line2 = [[UIView alloc] initForAutoLayout];
//    line2.backgroundColor = UIColor.qd_separatorColor;
//    [_otherWayView addSubview:line2];
//    [line2 autoSetDimension:ALDimensionHeight toSize:1];
//    [line2 autoSetDimension:ALDimensionWidth toSize:SS(20)];
//    [line2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:otherLabel];
//    [line2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:otherLabel withOffset:SS(9)];
//
//    UIButton *wxBtn = [[UIButton alloc] initForAutoLayout];
//    [wxBtn setImage:UIImageMake(@"微信登录") forState:UIControlStateNormal];
//    [wxBtn addTarget:self action:@selector(wxLogin) forControlEvents:UIControlEventTouchUpInside];
//    [_otherWayView addSubview:wxBtn];
//    [wxBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
//    [wxBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:otherLabel withOffset:SS(20)];
//    [wxBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
//    _checkView = [[ProtocolAndPrivacyView alloc] initForAutoLayout];
//    _checkView.isCheck = self.isCheck;
//    _checkView.qmui_outsideEdge = UIEdgeInsetsMake(SS(-20), SS(-20), SS(-20), 0);
//    _checkView.userInteractionEnabled = YES;
//    __weak __typeof(self)weakSelf = self;
//    _checkView.checkChangeBlock = ^{
//        weakSelf.isCheck = weakSelf.checkView.isCheck;
//        weakSelf.checkChangeBlock(weakSelf.isCheck);
//    };
//    [self.view addSubview:_checkView];
//    [_checkView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SafeAreaInsetsConstantForDeviceWithNotch.bottom + SS(60)];
//    [_checkView autoAlignAxisToSuperviewAxis:ALAxisVertical];
//
//    if ([WXApi isWXAppInstalled]) {
//        _otherWayView.hidden = NO;
//
//        [self.view addSubview:_otherWayView];
//        [_otherWayView autoAlignAxisToSuperviewAxis:ALAxisVertical];
//        [_otherWayView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        [_otherWayView autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        [_checkView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_otherWayView withOffset:SS(20)];
//    }
    
    UILabel *copyrightLabel = [[UILabel alloc] qmui_initWithFont:UIFont.qd_descriptionTextFont textColor:UIColor.qd_descriptionTextColor];
    copyrightLabel.text = @"⏤ 成都文通网络科技发展有限公司版权所有 ⏤";
    [self.view addSubview:copyrightLabel];
    [copyrightLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [copyrightLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(40)];
}

- (BOOL)preferredNavigationBarHidden {
    return YES;
}

- (void)changeWay {
    [self.navigationController popViewControllerAnimated:NO];
    if ([self isKindOfClass:[ZZPasswordLoginViewController class]]) {
        self.changeWayBlock(1);
    } else {
        self.changeWayBlock(0);
    }
}

- (void)login {
    
}

- (void)regist {
    
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    return YES;
}

- (void)wxLogin {
//    if (!_checkView.isCheck) {
//        [_checkView showActionSheet];
//        return;
//    }
//    [ComUserHelper pullWX:0];
}

#pragma mark - UITextViewDelegate

- (void)toRegist {
    [QDDialogHelper showAlertDialog:@"注册" content:@"账号密码由您所在的学校统一发放管理\n请联系管理员解决此类问题" okBlock:nil];
}


@end
