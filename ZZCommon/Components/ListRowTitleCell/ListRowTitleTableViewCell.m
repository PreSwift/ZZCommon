//
//  ListRowTitleTableViewCell.m

//  Created by westMac on 2021/8/16.
//

#import "ListRowTitleTableViewCell.h"

@interface ListRowTitleTableViewCell ()

@property(nonatomic, strong) UIView *decView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *allLabel;
@property(nonatomic, strong) UIImageView *allImageView;

@end

@implementation ListRowTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _decView = [[UIView alloc] initForAutoLayout];
    _decView.backgroundColor = UIColor.qd_tintColor;
    [self.contentView addSubview:_decView];
    [_decView autoPinEdgeToSuperviewEdge:ALEdgeTop  withInset:SS(15)];
    [_decView autoPinEdgeToSuperviewEdge:ALEdgeBottom    withInset:SS(15)];
    [_decView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(15)];
    [_decView autoSetDimension:ALDimensionWidth toSize:SS(4)];
    [_decView autoSetDimension:ALDimensionHeight toSize:SS(18)];
    
    _titleLabel = [[UILabel alloc] initForAutoLayout];
    _titleLabel.textColor = [UIColor qd_titleTextColor];
    _titleLabel.font = CodeFontMake(SS(14));
    [self.contentView addSubview:_titleLabel];
    [_titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_decView withOffset:SS(5)];
    [_titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_decView];
    
    
    _allLabel = [[UILabel alloc] initForAutoLayout];
    _allLabel.text = @"全部";
    _allLabel.textColor = [UIColor qd_descriptionTextColor];
    _allLabel.font = CodeFontMake(SS(12));
    [self.contentView addSubview:_allLabel];
    
    _allImageView = [[UIImageView alloc] initForAutoLayout];
    _allImageView.image = [UIImage imageNamed:@"右返回"];
    [self.contentView addSubview:_allImageView];
    [_allImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_allLabel withOffset:SS(5)];
    [_allImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_allLabel];
    [_allImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_decView];
    [_allImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(15)];
    
}

- (void)updateTitle:(NSString *)title showAll:(BOOL)showAll {
    self.titleLabel.text = title;
    [self.allLabel setHidden: !showAll];
    [self.allImageView setHidden:!showAll];
}

@end
