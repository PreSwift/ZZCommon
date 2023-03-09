//
//  QDDialogHelper.m
//  jzjx
//
//  Created by west007 on 2021/7/13.
//

#import "QDDialogHelper.h"

@implementation QDDialogHelper

+ (void)showAlertDialog:(NSString *)title content:(NSString *)content okBlock:(void (^)(__kindof QMUIModalPresentationViewController * _Nonnull))block {
    [QDDialogHelper showAlertDialog:title content:content okBtnTitle:@"我知道了" okBlock:block];
}

+ (void)showAlertDialog:(NSString *)title content:(NSString *)content okBtnTitle:(NSString *)okBtnTitle okBlock:(void (^)(__kindof QMUIModalPresentationViewController * _Nonnull))block {
    QMUIModalPresentationViewController *dialogViewController = [[QMUIModalPresentationViewController alloc] init];
    dialogViewController.contentViewMargins = UIEdgeInsetsMake(SS(40), SS(40), SS(40), SS(40));
    CGFloat maxWidth = MIN(DEVICE_WIDTH - SS(80), SS(300));
    CGFloat maxHeight = DEVICE_HEIGHT - SS(80);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    contentView.backgroundColor = UIColorWhite;
    contentView.layer.cornerRadius = CornerRadius(4);
    contentView.layer.masksToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
    titleLabel.font = CodeMediumFontMake(SS(16));
    titleLabel.textColor = UIColorMakeWithHex(@"#121312");
    titleLabel.text = title;
    [contentView addSubview:titleLabel];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4) relation:NSLayoutRelationGreaterThanOrEqual];
    [titleLabel autoSetDimension:ALDimensionHeight toSize:SS(55)];
    
    UILabel *contentLabel = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(14)) textColor:UIColorMakeWithHex(@"#0D0E11")];
    [contentLabel configureForAutoLayout];
    contentLabel.numberOfLines = 0;
    contentLabel.text = content;
    [contentView addSubview:contentLabel];
    CGSize contentLabelSize = [contentLabel sizeThatFits:CGSizeMake(maxWidth - Spaceing(8), maxHeight - SS(132))];
    [contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel];
    [contentLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [contentLabel autoSetDimension:ALDimensionWidth toSize:contentLabelSize.width];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:contentLabelSize.height];
    
    QMUIButton *okBtn = [[QMUIButton alloc] initForAutoLayout];
    [okBtn setTitle:okBtnTitle ? okBtnTitle : @"我知道了" forState:UIControlStateNormal];
    [okBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    okBtn.titleLabel.font = CodeFontMake(SS(14));
    okBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    okBtn.backgroundColor = UIColor.qd_tintColor;
    okBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (block) {
            block(dialogViewController);
        }
        [dialogViewController hideWithAnimated:YES completion:nil];
    };
    [contentView addSubview:okBtn];
    [okBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [okBtn autoSetDimensionsToSize:CGSizeMake(SS(200), SS(37))];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(20)];
    
    dialogViewController.contentView = contentView;
    dialogViewController.modal = YES;
    contentView.qmui_height = contentLabelSize.height + SS(132);
    [dialogViewController showWithAnimated:YES completion:nil];
}

+ (void)showNormalDialog:(NSString *)title content:(NSString *)content cancelBlock:(void (^)(__kindof QMUIModalPresentationViewController * _Nonnull))cancelBlock okBlock:(void (^)(__kindof QMUIModalPresentationViewController * _Nonnull))okBlock {
    QMUIModalPresentationViewController *dialogViewController = [[QMUIModalPresentationViewController alloc] init];
    dialogViewController.contentViewMargins = UIEdgeInsetsMake(SS(40), SS(40), SS(40), SS(40));
    CGFloat maxWidth = MIN(DEVICE_WIDTH - SS(80), SS(300));
    CGFloat maxHeight = DEVICE_HEIGHT - SS(80);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    contentView.backgroundColor = UIColorWhite;
    contentView.layer.cornerRadius = CornerRadius(4);
    contentView.layer.masksToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
    titleLabel.font = CodeMediumFontMake(SS(16));
    titleLabel.textColor = UIColor.qd_titleTextColor;
    titleLabel.text = title;
    [contentView addSubview:titleLabel];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4) relation:NSLayoutRelationGreaterThanOrEqual];
    [titleLabel autoSetDimension:ALDimensionHeight toSize:SS(55)];
    
    UILabel *contentLabel = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(13)) textColor:UIColor.qd_descriptionTextColor];
    [contentLabel configureForAutoLayout];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    contentLabel.text = content;
    [contentView addSubview:contentLabel];
    CGSize contentLabelSize = [contentLabel sizeThatFits:CGSizeMake(maxWidth - Spaceing(8), maxHeight - SS(132))];
    [contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel];
    [contentLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [contentLabel autoSetDimension:ALDimensionWidth toSize:contentLabelSize.width];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:contentLabelSize.height];
    
    UIView *centerView = [[UIView alloc] initForAutoLayout];
    [contentView addSubview:centerView];
    [centerView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [centerView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(20)];
    
    QMUIButton *cancelBtn = [[QMUIButton alloc] initForAutoLayout];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = CodeFontMake(SS(14));
    cancelBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    cancelBtn.backgroundColor = UIColor.qd_backgroundColorLighten;
    cancelBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (cancelBlock) {
            cancelBlock(dialogViewController);
        }
        [dialogViewController hideWithAnimated:YES completion:nil];
    };
    [centerView addSubview:cancelBtn];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [cancelBtn autoSetDimensionsToSize:CGSizeMake(SS(100), SS(37))];
    
    QMUIButton *okBtn = [[QMUIButton alloc] initForAutoLayout];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    okBtn.titleLabel.font = CodeFontMake(SS(14));
    okBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    okBtn.backgroundColor = UIColor.qd_tintColor;
    okBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (okBlock) {
            okBlock(dialogViewController);
        }
        [dialogViewController hideWithAnimated:YES completion:nil];
    };
    [centerView addSubview:okBtn];
    [okBtn autoSetDimensionsToSize:CGSizeMake(SS(100), SS(37))];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [okBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:cancelBtn];
    [okBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:cancelBtn withOffset:SS(20)];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    dialogViewController.contentView = contentView;
    contentView.qmui_height = contentLabelSize.height + SS(132);
    [dialogViewController showWithAnimated:YES completion:nil];
}

+ (void)showNormalDialog:(NSString *)title description:(NSString *)desc cancelBlock:(void (^)(__kindof QMUIDialogViewController * _Nonnull))cancelBlock okBlock:(void (^)(__kindof QMUIDialogViewController * _Nonnull))okBlock {
    QMUIDialogViewController *dialogViewController = [[QMUIDialogViewController alloc] init];
    dialogViewController.title = title;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SS(300), SS(100))];
    contentView.backgroundColor = UIColorWhite;
    UILabel *label = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(14)) textColor:UIColor.qd_titleTextColor];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = desc;
    label.bounds = CGRectMakeWithSize([label sizeThatFits:CGSizeMake(SS(260), SS(100))]);
    label.center = CGPointMake(CGRectGetWidth(contentView.bounds) / 2.0, CGRectGetHeight(contentView.bounds) / 2.0);
    [contentView addSubview:label];
    dialogViewController.contentView = contentView;
    [dialogViewController setButtonTitleAttributes:@{NSForegroundColorAttributeName: UIColor.qd_tintColor}];
    [dialogViewController addCancelButtonWithText:@"取消" block:^(__kindof QMUIDialogViewController * _Nonnull aDialogViewController) {
        if (cancelBlock) {
            cancelBlock(aDialogViewController);
        }
    }];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        [aDialogViewController hide];
        okBlock(aDialogViewController);
    }];
    [dialogViewController show];
}

+ (void)showAlert2Dialog: (NSString *)title description: (NSString *)desc okBlock: (void (^)(__kindof QMUIModalPresentationViewController *dialogViewController))block {
    CGRect labelRect = [desc boundingRectWithSize:CGSizeMake(SS(220), SCREEN_HEIGHT) options:0 attributes:@{NSFontAttributeName : CodeFontMake(SS(14))} context:nil];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SS(240), SS(130) + labelRect.size.height)];
    
    contentView.backgroundColor = UIColor.qd_backgroundColorLighten;
    contentView.layer.cornerRadius = 10;
    
    UILabel *titleLabel = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(14)) textColor:UIColor.qd_descriptionTextColor];
    [titleLabel configureForAutoLayout];
    titleLabel.text = title;
    [contentView addSubview:titleLabel];
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SS(15)];
    
    UIButton *cancelBtn = [[UIButton alloc] initForAutoLayout];
    [cancelBtn setImage:[[UIImage imageNamed:@"关闭叉"] qmui_imageWithTintColor:titleLabel.textColor] forState:UIControlStateNormal];
    cancelBtn.qmui_outsideEdge = UIEdgeInsetsMake(-SS(10), -SS(10), -SS(10), -SS(10));
    [contentView addSubview:cancelBtn];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(10)];
    [cancelBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:titleLabel];
    [cancelBtn autoSetDimensionsToSize:CGSizeMake(SS(20), SS(30))];
    
    UILabel *label = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(14)) textColor:UIColor.qd_titleTextColor];
    [label configureForAutoLayout];
    label.numberOfLines = 0;
    label.text = desc;
    label.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:label];
    [label autoAlignAxis:ALAxisVertical toSameAxisOfView:contentView];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(10) relation:NSLayoutRelationGreaterThanOrEqual];
    [label autoAlignAxis:ALAxisHorizontal toSameAxisOfView:contentView withOffset:-SS(5)];
    
    QMUIButton *actionBtn = [[QMUIButton alloc] initForAutoLayout];
    actionBtn.backgroundColor = UIColor.qd_tintColor;
    actionBtn.cornerRadius = SS(4);
    actionBtn.titleLabel.font = CodeFontMake(SS(13));
    [actionBtn setTitle:@"确定" forState:UIControlStateNormal];
    [actionBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [contentView addSubview:actionBtn];
    [actionBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(15)];
    [actionBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [actionBtn autoSetDimensionsToSize:CGSizeMake(SS(60), SS(30))];
    
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentView = contentView;
    cancelBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
    };
    actionBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
        block(modalViewController);
    };
    [modalViewController showWithAnimated:YES completion:nil];
}

+ (void)showVersionUpdateDialog:(NSString *)title description:(NSString *)desc url:(NSString *)url isForceUpdate:(BOOL)isForceUpdate {
    QMUIModalPresentationViewController *dialogViewController = [[QMUIModalPresentationViewController alloc] init];
    dialogViewController.contentViewMargins = UIEdgeInsetsMake(SS(45), SS(45), SS(45), SS(45));
    CGFloat maxWidth = SS(285);
    CGFloat maxHeight = DEVICE_HEIGHT - SS(80);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    contentView.backgroundColor = UIColorWhite;
    contentView.layer.cornerRadius = CornerRadius(4);
    contentView.layer.masksToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initForAutoLayout];
    imageView.image = UIImageMake(@"小火箭");
    [contentView addSubview:imageView];
    [imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [imageView autoPinEdgeToSuperviewSafeArea:ALEdgeTop withInset:SS(12)];
    
    UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
    titleLabel.font = CodeMediumFontMake(SS(16));
    titleLabel.textColor = UIColor.qd_titleTextColor;
    titleLabel.text = @"发现新版本";
    [contentView addSubview:titleLabel];
    [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageView withOffset:SS(12)];
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4) relation:NSLayoutRelationGreaterThanOrEqual];
    
    QMUILabel *versionLabel = [[QMUILabel alloc] initForAutoLayout];
    versionLabel.contentEdgeInsets = UIEdgeInsetsMake(SS(2), SS(8), SS(2), SS(8));
    versionLabel.font = CodeFontMake(SS(11));
    versionLabel.textColor = UIColor.whiteColor;
    versionLabel.backgroundColor = UIColorMakeWithHex(@"#3F87F4");
    versionLabel.text = title;
    versionLabel.layer.cornerRadius = CornerRadius(1);
    versionLabel.layer.masksToBounds = YES;
    [contentView addSubview:versionLabel];
    [versionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:SS(9)];
    [versionLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [versionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4) relation:NSLayoutRelationGreaterThanOrEqual];
    
    UILabel *contentLabel = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(14)) textColor:UIColor.qd_titleTextColor];
    [contentLabel configureForAutoLayout];
    contentLabel.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = SS(4);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:desc attributes:attributes];
    contentLabel.attributedText = attr;
    [contentView addSubview:contentLabel];
    CGSize contentLabelSize = [contentLabel sizeThatFits:CGSizeMake(maxWidth - SS(40), maxHeight - SS(229))];
    [contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:versionLabel withOffset:SS(12)];
    [contentLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [contentLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(20)];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:contentLabelSize.height];
    
    UIView *centerView = [[UIView alloc] initForAutoLayout];
    [contentView addSubview:centerView];
    [centerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    
    UIView *line1 = [[UIView alloc] initForAutoLayout];
    line1.backgroundColor = UIColor.qd_imageViewBackgroundColor;
    [centerView addSubview:line1];
    [line1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [line1 autoSetDimension:ALDimensionHeight toSize:1];
    
    QMUIButton *okBtn = [[QMUIButton alloc] initForAutoLayout];
    [okBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [okBtn setTitleColor:UIColorMakeWithHex(@"#3F87F4") forState:UIControlStateNormal];
    okBtn.titleLabel.font = CodeFontMake(SS(16));
    okBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (!isForceUpdate) {
            [dialogViewController hideWithAnimated:YES completion:nil];
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    };
    [centerView addSubview:okBtn];
    [okBtn autoSetDimension:ALDimensionHeight toSize:SS(47)];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    if (!isForceUpdate) {
        QMUIButton *cancelBtn = [[QMUIButton alloc] initForAutoLayout];
        [cancelBtn setTitle:@"暂时忽略" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:UIColor.qd_descriptionTextColor forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = CodeFontMake(SS(16));
        cancelBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
            [dialogViewController hideWithAnimated:YES completion:nil];
        };
        [centerView addSubview:cancelBtn];
        [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [cancelBtn autoSetDimension:ALDimensionHeight toSize:SS(47)];
        
        UIView *line2 = [[UIView alloc] initForAutoLayout];
        line2.backgroundColor = UIColor.qd_imageViewBackgroundColor;
        [centerView addSubview:line2];
        [line2 autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [line2 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [line2 autoSetDimension:ALDimensionWidth toSize:1];
        [line2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:cancelBtn];
        
        [okBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:cancelBtn];
        [okBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:line2];
    } else {
        [okBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    }
    
    dialogViewController.contentView = contentView;
    contentView.qmui_height = contentLabelSize.height + SS(229);
    [dialogViewController showWithAnimated:YES completion:nil];
}

+ (void)showNoticeDialog:(NSString *)title description:(NSString *)desc {
    QMUIModalPresentationViewController *dialogViewController = [[QMUIModalPresentationViewController alloc] init];
    dialogViewController.contentViewMargins = UIEdgeInsetsMake(SS(40), SS(40), SS(40), SS(40));
    CGFloat maxWidth = MIN(DEVICE_WIDTH - SS(80), SS(300));
    CGFloat maxHeight = DEVICE_HEIGHT - SS(80);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    contentView.backgroundColor = UIColorWhite;
    contentView.layer.cornerRadius = CornerRadius(4);
    contentView.layer.masksToBounds = YES;
    
    UIButton *titleLabel = [[UIButton alloc] initForAutoLayout];
    titleLabel.userInteractionEnabled = NO;
    titleLabel.titleLabel.font = CodeMediumFontMake(SS(16));
    [titleLabel setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
    [titleLabel setTitle:title forState:UIControlStateNormal];
    [titleLabel setBackgroundImage:UIImageMake(@"背景1") forState:UIControlStateNormal];
    [contentView addSubview:titleLabel];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [titleLabel autoSetDimension:ALDimensionHeight toSize:SS(62.5)];
    
    UILabel *contentLabel = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(14)) textColor:UIColor.qd_titleTextColor];
    [contentLabel configureForAutoLayout];
    contentLabel.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = SS(4);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:desc attributes:attributes];
    contentLabel.attributedText = attr;
    
    [contentView addSubview:contentLabel];
    CGSize contentLabelSize = [desc boundingRectWithSize:CGSizeMake(maxWidth - Spaceing(8), maxHeight - SS(132)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: UIFont.qd_mainTextFont, NSParagraphStyleAttributeName: paragraphStyle} context:nil].size;
    [contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:SS(20)];
    [contentLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [contentLabel autoSetDimension:ALDimensionWidth toSize:contentLabelSize.width];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:contentLabelSize.height];
    
    QMUIButton *okBtn = [[QMUIButton alloc] initForAutoLayout];
    [okBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [okBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    okBtn.titleLabel.font = CodeFontMake(SS(14));
    okBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    okBtn.backgroundColor = UIColor.qd_tintColor;
    okBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [dialogViewController hideWithAnimated:YES completion:nil];
    };
    [contentView addSubview:okBtn];
    [okBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [okBtn autoSetDimensionsToSize:CGSizeMake(SS(200), SS(37))];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(20)];
    
    dialogViewController.contentView = contentView;
    dialogViewController.modal = YES;
    contentView.qmui_height = contentLabelSize.height + SS(160);
    [dialogViewController showWithAnimated:YES completion:nil];
}

+ (void)showBindTipsWithOkBlock:(void (^)(__kindof QMUIModalPresentationViewController * _Nonnull))block {
    QMUIModalPresentationViewController *dialogViewController = [[QMUIModalPresentationViewController alloc] init];
    dialogViewController.contentViewMargins = UIEdgeInsetsMake(SS(40), SS(40), SS(40), SS(40));
    CGFloat maxWidth = MIN(DEVICE_WIDTH - SS(80), SS(300));
    CGFloat maxHeight = DEVICE_HEIGHT - SS(80);
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 0)];
    contentView.backgroundColor = UIColorWhite;
    contentView.layer.cornerRadius = CornerRadius(4);
    contentView.layer.masksToBounds = YES;
    
    UIButton *titleLabel = [[UIButton alloc] initForAutoLayout];
    titleLabel.userInteractionEnabled = NO;
    titleLabel.titleLabel.font = CodeMediumFontMake(SS(16));
    [titleLabel setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
    [titleLabel setTitle:@"微信及手机验证码登录操作说明" forState:UIControlStateNormal];
    [titleLabel setBackgroundImage:UIImageMake(@"背景1") forState:UIControlStateNormal];
    [contentView addSubview:titleLabel];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [titleLabel autoSetDimension:ALDimensionHeight toSize:SS(62.5)];
    
    UILabel *contentLabel = [[UILabel alloc] qmui_initWithFont:CodeFontMake(SS(13)) textColor:UIColor.qd_titleTextColor];
    [contentLabel configureForAutoLayout];
    contentLabel.numberOfLines = 0;
    NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n",
                         @"1、首次登录请使用帐号密码进行登录；",
                         @"2、如果是通过网页登录，登录后点击右上角个人头像处，进入个人中心；",
                         @"3、在个人中心页面中可执行绑定手机号、绑定微信、修改密码的操作；",
                         @"4、如果是在手机APP中登录，登录后点击“我的”菜单；",
                         @"5、在菜单页面中可执行绑定手机号、绑定微信、修改密码的操作；",
                         @"6、完成手机号及微信绑定后，下次登录即可使用手机验证码登录及微信登录的方式；"];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = SS(4);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    contentLabel.attributedText = attr;
    
    [contentView addSubview:contentLabel];
    CGSize contentLabelSize = [contentLabel sizeThatFits:CGSizeMake(maxWidth - Spaceing(8), maxHeight - SS(132))];
    [contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:SS(20)];
    [contentLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [contentLabel autoSetDimension:ALDimensionWidth toSize:contentLabelSize.width];
    [contentLabel autoSetDimension:ALDimensionHeight toSize:contentLabelSize.height];
    
    QMUIButton *okBtn = [[QMUIButton alloc] initForAutoLayout];
    [okBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [okBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    okBtn.titleLabel.font = CodeFontMake(SS(14));
    okBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    okBtn.backgroundColor = UIColor.qd_tintColor;
    okBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (block) {
            block(dialogViewController);
        }
        [dialogViewController hideWithAnimated:YES completion:nil];
    };
    [contentView addSubview:okBtn];
    [okBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [okBtn autoSetDimensionsToSize:CGSizeMake(SS(200), SS(37))];
    [okBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(20)];
    
    dialogViewController.contentView = contentView;
    dialogViewController.modal = YES;
    contentView.qmui_height = contentLabelSize.height + SS(145);
    [dialogViewController showWithAnimated:YES completion:nil];
}

@end
