//
//  ZZFormRowTableViewCell.m

//  Created by Ethan on 2022/9/28.
//

#import "ZZFormRowTableViewCell.h"
#import "ZZCommonMacros.h"

@interface ZZFormRowTableViewCell()

@property(nonatomic, strong) ZZFormRowView *rowView;

@end

@implementation ZZFormRowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _rowView = [[ZZFormRowView alloc] initForAutoLayout];
    [self.contentView addSubview:_rowView];
}

- (void)updateWithRowModel:(ZZFormRowModel *)rowModel {
    [_rowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).inset(rowModel.padding.left);
        make.right.equalTo(self.contentView.mas_right).inset(rowModel.padding.right).priorityHigh();
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [_rowView updateUIWith:rowModel];
}

- (void)updateWithRowModel:(ZZFormRowModel *)rowModel toItemIndex:(NSInteger)toItemIndex {
    [_rowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).inset(rowModel.padding.left);
        make.right.equalTo(self.contentView.mas_right).inset(rowModel.padding.right).priorityHigh();
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [_rowView updateUIWith:rowModel toItemIndex:toItemIndex];
}

@end
