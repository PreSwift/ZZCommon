//
//  ZZFormRowTableViewCell.m
//  jzjx
//
//  Created by Ethan on 2022/9/28.
//

#import "ZZFormRowTableViewCell.h"

@interface ZZFormRowTableViewCell()

@property(nonatomic, strong) ZZFormRowView *rowView;
@property(nonatomic, strong) ZZFormRowModel *rowModel;

@end

@implementation ZZFormRowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initSubviews {
    _rowView = [[ZZFormRowView alloc] initForAutoLayout];
    __weak __typeof(self)weakSelf = self;
    _rowView.tapCellBlock = ^(NSInteger column, QMUIButton *sender) {
        if (weakSelf.tapCellBlock) {
            weakSelf.tapCellBlock(weakSelf.rowModel, column, sender);
        }
    };
    [self.contentView addSubview:_rowView];
    
    _selectedMaskView = [[UIView alloc] initForAutoLayout];
    _selectedMaskView.userInteractionEnabled = NO;
    _selectedMaskView.hidden = YES;
    [self.contentView addSubview:_selectedMaskView];
    [_selectedMaskView autoPinEdgesToSuperviewEdges];
}

- (void)updateWithRowModel:(ZZFormRowModel *)rowModel {
    self.rowModel = rowModel;
    [_rowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).inset(rowModel.padding.left);
        make.right.equalTo(self.contentView.mas_right).inset(rowModel.padding.right).priorityHigh();
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [_rowView updateUIWith:rowModel];
}

- (void)updateWithRowModel:(ZZFormRowModel *)rowModel toItemIndex:(NSInteger)toItemIndex {
    self.rowModel = rowModel;
    [_rowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).inset(rowModel.padding.left);
        make.right.equalTo(self.contentView.mas_right).inset(rowModel.padding.right).priorityHigh();
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [_rowView updateUIWith:rowModel toItemIndex:toItemIndex];
}

@end
