//
//  ProtocolAndPrivacyView.m

//  Created by mac on 2022/8/24.
//

#import "ProtocolAndPrivacyView.h"
#import "CommonWebViewController.h"

@interface ProtocolAndPrivacyView ()

@property(nonatomic, strong) UIButton *checkBtn;
@property(nonatomic, strong) QMUIModalPresentationViewController *presentationView;

@end

@implementation ProtocolAndPrivacyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _checkBtn = [[UIButton alloc] initForAutoLayout];
    _checkBtn.qmui_outsideEdge = UIEdgeInsetsMake(SS(-20), SS(-20), SS(-20), SS(-50));
    [_checkBtn setImage:UIImageMake(@"新选中") forState:UIControlStateSelected];
    [_checkBtn setImage:UIImageMake(@"新未选中") forState:UIControlStateNormal];
    [_checkBtn addTarget:self action:@selector(checkCondition:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *protocolTV = [[UIView alloc] initForAutoLayout];
    UILabel *label1 = [[UILabel alloc] qmui_initWithFont:UIFont.qd_descriptionTextFont textColor:UIColor.qd_descriptionTextColor];
    label1.text = @"已阅读并同意";
    [protocolTV addSubview:label1];
    [label1 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [label1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [label1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
    UIButton *btn1 = [[UIButton alloc] initForAutoLayout];
    [btn1 setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
    btn1.titleLabel.font = UIFont.qd_descriptionTextFont;
    [btn1 setTitle:@"《隐私政策》" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(toPrivacypolicy) forControlEvents:UIControlEventTouchUpInside];
    [protocolTV addSubview:btn1];
    [btn1 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [btn1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:label1];
    UILabel *label2 = [[UILabel alloc] qmui_initWithFont:UIFont.qd_descriptionTextFont textColor:UIColor.qd_descriptionTextColor];
    label2.text = @"和";
    [protocolTV addSubview:label2];
    [label2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [label2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:btn1];
    UIButton *btn2 = [[UIButton alloc] initForAutoLayout];
    [btn2 setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
    btn2.titleLabel.font = UIFont.qd_descriptionTextFont;
    [btn2 setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(toUseragreement) forControlEvents:UIControlEventTouchUpInside];
    [protocolTV addSubview:btn2];
    [btn2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [btn2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:label2];
    [btn2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self addSubview:protocolTV];
    [self addSubview:_checkBtn];
    [_checkBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_checkBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_checkBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:Spaceing(3)];
    [_checkBtn autoSetDimensionsToSize:CGSizeMake(SS(12), SS(12))];
    [protocolTV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_checkBtn withOffset:Spaceing(1)];
    [protocolTV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [protocolTV autoPinEdgeToSuperviewEdge:ALEdgeRight];
}

- (void)setIsCheck:(BOOL)isCheck {
    _checkBtn.selected = isCheck;
}

- (BOOL)isCheck {
    return _checkBtn.isSelected;
}

- (void)checkCondition: (UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.checkChangeBlock) {
        self.checkChangeBlock();
    }
}

- (void)toPrivacypolicy {
    [self.presentationView hideWithAnimated:YES completion:nil];
    NSString *url = [NSString stringWithFormat:@"%@?type=%@", CREAT_WEB_URL(@"#/privacyPolicy"), @"teacher"];
    CommonWebViewController *vc = [[CommonWebViewController alloc] initWithUrl:url];
    [self.qmui_viewController.navigationController pushViewController:vc animated:YES];
}

- (void)toUseragreement {
    [self.presentationView hideWithAnimated:YES completion:nil];
    NSString *url = [NSString stringWithFormat:@"%@?type=%@", CREAT_WEB_URL(@"#/userAgreement"), @"teacher"];
    CommonWebViewController *vc = [[CommonWebViewController alloc] initWithUrl:url];
    [self.qmui_viewController.navigationController pushViewController:vc animated:YES];
}

- (void)showActionSheet {
    if (self.presentationView== nil) {
        QMUIModalPresentationViewController *dialogViewController = [[QMUIModalPresentationViewController alloc] init];
        dialogViewController.contentViewMargins = UIEdgeInsetsZero;
        dialogViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, SS(229) + SafeAreaInsetsConstantForDeviceWithNotch.bottom)];
        contentView.backgroundColor = UIColorWhite;
        contentView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
        contentView.layer.cornerRadius = CornerRadius(4);
        contentView.layer.masksToBounds = YES;
        
        UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
        titleLabel.font = CodeMediumFontMake(SS(16));
        titleLabel.textColor = UIColor.qd_titleTextColor;
        titleLabel.text = @"请阅读并同意以下条款";
        [contentView addSubview:titleLabel];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4) relation:NSLayoutRelationGreaterThanOrEqual];
        [titleLabel autoSetDimension:ALDimensionHeight toSize:SS(54)];
        
        UIButton *cancelBtn = [[UIButton alloc] initForAutoLayout];
        [cancelBtn setImage:[[UIImage imageNamed:@"关闭叉"] qmui_imageWithBlendColor:UIColor.blackColor] forState:UIControlStateNormal];
        cancelBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
            [dialogViewController hideWithAnimated:YES completion:nil];
        };
        cancelBtn.qmui_outsideEdge = UIEdgeInsetsMake(-SS(20), -SS(20), -SS(20), -SS(20));
        [contentView addSubview:cancelBtn];
        [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(16)];
        [cancelBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:titleLabel];
        [cancelBtn autoSetDimensionsToSize:CGSizeMake(SS(20), SS(20))];
        
        UIView *line1 = [[UIView alloc] initForAutoLayout];
        line1.backgroundColor = UIColor.qd_imageViewBackgroundColor;
        [contentView addSubview:line1];
        [line1 autoSetDimension:ALDimensionHeight toSize:1];
        [line1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [line1 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [line1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SS(54)];
        
        UIView *protocolTV = [[UIView alloc] initForAutoLayout];
        UIButton *btn1 = [[UIButton alloc] initForAutoLayout];
        [btn1 setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
        btn1.titleLabel.font = UIFont.qd_descriptionTextFont;
        [btn1 setTitle:@"《隐私政策》" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(toPrivacypolicy) forControlEvents:UIControlEventTouchUpInside];
        [protocolTV addSubview:btn1];
        [btn1 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [btn1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        UILabel *label2 = [[UILabel alloc] qmui_initWithFont:UIFont.qd_descriptionTextFont textColor:UIColor.qd_descriptionTextColor];
        label2.text = @"和";
        [protocolTV addSubview:label2];
        [label2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [label2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:btn1];
        UIButton *btn2 = [[UIButton alloc] initForAutoLayout];
        [btn2 setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
        btn2.titleLabel.font = UIFont.qd_descriptionTextFont;
        [btn2 setTitle:@"《用户协议》" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(toUseragreement) forControlEvents:UIControlEventTouchUpInside];
        [protocolTV addSubview:btn2];
        [btn2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [btn2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:label2];
        [btn2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [contentView addSubview:protocolTV];
        [protocolTV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [protocolTV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SS(90)];
        [protocolTV autoSetDimension:ALDimensionHeight toSize:SS(40)];
        
        UIView *line2 = [[UIView alloc] initForAutoLayout];
        line2.backgroundColor = UIColor.qd_imageViewBackgroundColor;
        [contentView addSubview:line2];
        [line2 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SS(151)];
        [line2 autoSetDimension:ALDimensionHeight toSize:PixelOne];
        [line2 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [line2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        QMUIButton *okBtn = [[QMUIButton alloc] initForAutoLayout];
        [okBtn setTitle:@"同意并继续" forState:UIControlStateNormal];
        [okBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
        okBtn.titleLabel.font = CodeMediumFontMake(SS(16));
        okBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
        okBtn.backgroundColor = UIColor.qd_tintColor;
        __weak __typeof(self)weakSelf = self;
        okBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
            weakSelf.isCheck = YES;
            [dialogViewController hideWithAnimated:YES completion:nil];
        };
        [contentView addSubview:okBtn];
        [okBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line2 withOffset:SS(20)];
        [okBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [okBtn autoSetDimension:ALDimensionHeight toSize:SS(38)];
        [okBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(16)];
        
        dialogViewController.contentView = contentView;
        dialogViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
            contentView.qmui_frameApplyTransform = CGRectSetXY(contentView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(contentView.frame)), CGRectGetHeight(containerBounds) - CGRectGetHeight(contentView.frame));
        };
        self.presentationView = dialogViewController;
    }
    
    [self.presentationView showWithAnimated:YES completion:nil];
}

@end
