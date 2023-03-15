//
//  CheckImageButton.m

//  Created by mac on 2022/3/8.
//

#import "CheckImageButton.h"

@interface CheckImageButton ()

@property(nonatomic, strong) UIImageView *checkMarkView;

@end

@implementation CheckImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _checkMarkView = [[UIImageView alloc] initForAutoLayout];
    _checkMarkView.image = [UIImage imageNamed:@"未选中"];
    [self addSubview:_checkMarkView];
    [_checkMarkView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SS(5)];
    [_checkMarkView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(5)];
    [_checkMarkView autoSetDimensionsToSize:CGSizeMake(SS(14), SS(14))];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    _checkMarkView.image = selected ? [UIImage imageNamed:@"选中"] : [UIImage imageNamed:@"未选中"];
}

@end
