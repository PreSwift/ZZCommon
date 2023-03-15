//
//  QDFilterItemCell.m
//  jzjx
//
//  Created by mac on 2022/8/10.
//

#import "QDFilterItemCell.h"

@interface QDFilterItemCell ()

@property(nonatomic, strong) QMUIButton *button;

@end

@implementation QDFilterItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _button = [QDUIHelper generateGhostButton];
    _button.userInteractionEnabled = NO;
    [self.contentView addSubview:_button];
    [_button autoPinEdgesToSuperviewEdges];
}

- (void)updateWithTitle:(NSString *)title isSelected:(BOOL)isSelected {
    [_button setTitle:title forState:UIControlStateNormal];
    _button.selected = isSelected;
}

@end
