//
//  QMUICommonViewController+Alert.m

//  Created by mac on 2022/3/29.
//

#import "QMUICommonViewController+Alert.h"

@implementation QMUICommonViewController (Alert)

- (void)showTopAlertWith:(NSString *)title {
    [self showTopAlertWith:title offset:0];
}

- (void)showTopAlertWith:(NSString *)title offset:(CGFloat)offset {
    UIView *backView = [[UIView alloc] initForAutoLayout];
    backView.backgroundColor = UIColorBlack;
    backView.alpha = 0.8;
    backView.tag = 779;
    [self.view addSubview:backView];
    [backView autoPinEdgesToSuperviewSafeAreaWithInsets:UIEdgeInsetsMake(offset, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [backView autoSetDimension:ALDimensionHeight toSize:SS(28)];
    
    UIView *centerView = [[UIView alloc] initForAutoLayout];
    [backView addSubview:centerView];
    [centerView autoCenterInSuperview];
    [centerView autoSetDimension:ALDimensionHeight toSize:SS(28)];
    
    UIImageView *markView = [[UIImageView alloc] initForAutoLayout];
    markView.image = UIImageMake(@"toast_icon_warning");
    [centerView addSubview:markView];
    [markView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [markView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [markView autoSetDimensionsToSize:CGSizeMake(SS(12), SS(12))];
    
    UILabel *contentLabel = [[UILabel alloc] initForAutoLayout];
    contentLabel.textColor = UIColorWhite;
    contentLabel.font = UIFont.qd_descriptionTextFont;
    contentLabel.text = title;
    [centerView addSubview:contentLabel];
    [contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:markView withOffset:Spaceing(1)];
    [contentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [contentLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:markView];
    
    UIButton *cancelBtn = [[UIButton alloc] initForAutoLayout];
    [cancelBtn setImage:UIImageMake(@"关闭白色叉") forState:UIControlStateNormal];
    cancelBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [backView removeFromSuperview];
    };
    [backView addSubview:cancelBtn];
    [cancelBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4)];
    [cancelBtn autoSetDimensionsToSize:CGSizeMake(SS(28), SS(28))];
    [cancelBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:centerView withOffset:0 relation:NSLayoutRelationGreaterThanOrEqual];
}

@end
