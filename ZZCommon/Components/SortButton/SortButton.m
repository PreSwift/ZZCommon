//
//  SortButton.m

//  Created by mac on 2022/3/30.
//

#import "SortButton.h"
#import "ZZCommonMacros.h"

@interface SortButton ()

@property(nonatomic, strong) UILabel *_titleLabel;
@property(nonatomic, strong) UIImageView *_sortImageView;

@end

@implementation SortButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sortState = SortButtonStateNoSort;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    UIView *contentView = [[UIView alloc] initForAutoLayout];
    contentView.userInteractionEnabled = NO;
    [self addSubview:contentView];
    [contentView autoCenterInSuperview];
    [contentView autoSetDimension:ALDimensionHeight toSize:SS(20)];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    [contentView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    
    self._titleLabel = [[UILabel alloc] initForAutoLayout];
    self._titleLabel.font = UIFont.qd_mainTextMediumFont;
    self._titleLabel.textColor = UIColorMakeWithHex(@"#999899");
    [contentView addSubview:self._titleLabel];
    [self._titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self._titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self._titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    
    self._sortImageView = [[UIImageView alloc] initForAutoLayout];
    [self._sortImageView setImage:UIImageMake(@"排序")];
    [contentView addSubview:self._sortImageView];
    [self._sortImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self._titleLabel];
    [self._sortImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self._titleLabel withOffset:Spaceing(1)];
    [self._sortImageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self._sortImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0 relation:NSLayoutRelationGreaterThanOrEqual];
    
    __weak __typeof(self)weakSelf = self;
    self.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (weakSelf.sortState == SortButtonStateNoSort) {
            weakSelf.sortState = SortButtonStateSortUp;
        } else if (weakSelf.sortState == SortButtonStateSortUp) {
            weakSelf.sortState = SortButtonStateSortDown;
        } else if (weakSelf.sortState == SortButtonStateSortDown) {
            weakSelf.sortState = SortButtonStateSortUp;
        }
        if (weakSelf.sortChangeBlock) {
            weakSelf.sortChangeBlock(weakSelf.sortState);
        }
    };
}

- (void)setSortState:(SortButtonState)sortState {
    _sortState = sortState;
    if (sortState == SortButtonStateNoSort) {
        self._titleLabel.textColor = UIColorMakeWithHex(@"#999899");
        self._sortImageView.image = UIImageMake(@"排序");
    } else if (sortState == SortButtonStateSortDown) {
        self._titleLabel.textColor = UIColor.qd_tintColor;
        self._sortImageView.image = UIImageMake(@"排序升");
    } else if (sortState == SortButtonStateSortUp) {
        self._titleLabel.textColor = UIColor.qd_tintColor;
        self._sortImageView.image = UIImageMake(@"排序降");
    }
}

- (void)setTitle:(NSString *)title {
    __titleLabel.text = title;
}

- (NSString *)title {
    return __titleLabel.text;
}

@end
