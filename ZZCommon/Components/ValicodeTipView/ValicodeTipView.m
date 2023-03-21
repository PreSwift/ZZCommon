//
//  ValicodeTipView.m

//  Created by mac on 2022/8/26.
//

#import "ValicodeTipView.h"
#import "ZZCommonMacros.h"

@interface ValicodeTipView ()

@property(nonatomic, strong) UILabel *tipLabel;

@end

@implementation ValicodeTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = UIColorMakeWithHex(@"#FFFBE6");
    
    UIImageView *notiImageView = [[UIImageView alloc] initWithImage:[UIImageMake(@"消息-通知") qmui_imageWithTintColor:UIColorMakeWithHex(@"#FCAD38")]];
    [self addSubview:notiImageView];
    [notiImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [notiImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4)];
    
    UILabel *tipLabel = [[UILabel alloc] initForAutoLayout];
    tipLabel.font = UIFont.qd_descriptionTextFont;
    tipLabel.textColor = UIColorMakeWithHex(@"#FCAD38");
    tipLabel.numberOfLines = 0;
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;
    [tipLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:notiImageView withOffset:Spaceing(2)];
    [tipLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4) relation:NSLayoutRelationGreaterThanOrEqual];
    [tipLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:Spaceing(3)];
    [tipLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:Spaceing(3)];
}

- (void)updateContent:(NSString *)content {
    _tipLabel.text = content;
}

@end
