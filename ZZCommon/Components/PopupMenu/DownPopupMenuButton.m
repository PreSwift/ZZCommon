//
//  DownPopupMenuButton.m

//  Created by mac on 2022/3/10.
//

#import "DownPopupMenuButton.h"
#import "ZZCommonMacros.h"

@interface DownPopupMenuButton<T:NSObject *> ()

/**
 标题文字
 */
@property(nonatomic, strong) UILabel *leftLabel;

@end

@implementation DownPopupMenuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setStyle];
    }
    return self;
}

- (void)setStyle {
    self.spacingBetweenImageAndTitle = SS(5);
    self.titleLabel.font = CodeFontMake(SS(12));
    self.titleLabel.lineBreakMode = NSLineBreakByClipping;
    [self setTitleColor:UIColor.qd_mainTextColor forState:UIControlStateNormal];
    self.imagePosition = QMUIButtonImagePositionRight;
    [self setImage:[UIImage imageNamed:@"三角下"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"三角上"] forState:UIControlStateSelected];
    __weak __typeof(self)weakSelf = self;
    self.menuView.willShowBlock = ^(BOOL animated) {
        weakSelf.selected = YES;
    };
    self.menuView.willHideBlock = ^(BOOL hidesByUserTap, BOOL animated) {
        weakSelf.selected = NO;
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftLabel.center = CGPointMake(self.leftLabel.qmui_width / 2, self.qmui_height / 2);
}

- (void)setLeftTitle:(NSString *)leftTitle {
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.font = self.titleLabel.font;
    leftLabel.text = leftTitle;
    leftLabel.textColor = UIColor.qd_mainTextColor;
    [self addSubview:leftLabel];
    self.leftLabel = leftLabel;
    [self.leftLabel sizeToFit];
    self.contentEdgeInsets = UIEdgeInsetsMake(0, self.leftLabel.qmui_width + SS(5), 0, 0);
}

@end
