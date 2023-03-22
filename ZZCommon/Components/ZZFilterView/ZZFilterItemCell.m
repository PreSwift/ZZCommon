//
//  ZZFilterItemCell.m

//  Created by mac on 2022/8/10.
//

#import "ZZFilterItemCell.h"
#import <QMUIKit/QMUIKit.h>
#import <PureLayout/PureLayout.h>
#import "ZZUIHelper.h"

@interface ZZFilterItemCell ()

@property(nonatomic, strong) QMUIButton *button;

@end

@implementation ZZFilterItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _button = [ZZUIHelper generateGhostButton];
    _button.userInteractionEnabled = NO;
    [self.contentView addSubview:_button];
    [_button autoPinEdgesToSuperviewEdges];
}

- (void)updateWithTitle:(NSString *)title isSelected:(BOOL)isSelected {
    [_button setTitle:title forState:UIControlStateNormal];
    _button.selected = isSelected;
}

@end
