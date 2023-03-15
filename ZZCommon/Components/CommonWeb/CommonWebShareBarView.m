//
//  CommonWebShareBarView.m

//  Created by westMac on 2022/1/7.
//

#import "CommonWebShareBarView.h"

@interface CommonWebShareBarView ()

@property(nonatomic, strong) QMUIButton *shareBtn;
@property(nonatomic, strong) QMUIButton *emailBtn;

@end

@implementation CommonWebShareBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    _thisViewHeight = SS(50);
    
    _shareBtn = [[QMUIButton alloc] initForAutoLayout];
    [_shareBtn setImagePosition:QMUIButtonImagePositionTop];
    [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    _shareBtn.titleLabel.font = CodeFontMake(SS(12));
    [self addSubview:_shareBtn];
    [_shareBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_shareBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SCREEN_WIDTH / 4];
    
    _emailBtn = [[QMUIButton alloc] initForAutoLayout];
    [_emailBtn setImagePosition:QMUIButtonImagePositionTop];
    [_emailBtn setImage:[UIImage imageNamed:@"邮件"] forState:UIControlStateNormal];
    [_emailBtn setTitle:@"邮件" forState:UIControlStateNormal];
    [_emailBtn setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
    _emailBtn.titleLabel.font = CodeFontMake(SS(12));
    [_emailBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_emailBtn];
    [_emailBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_emailBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SCREEN_WIDTH / 4];
    
}


- (void)tapAction: (UIButton *)sender {
    if (sender == _shareBtn) {
        if (_tapShareBtnBlock){
            _tapShareBtnBlock();
        }
    } else if (sender == _emailBtn) {
        if (_tapEmailBtnBlock){
            _tapEmailBtnBlock();
        }
    }
}

@end
