//
//  ZZFormRowView.m

//  Created by mac on 2023/2/13.
//

#import "ZZFormRowView.h"
#import "ZZCommonMacros.h"

@interface ZZFormRowView ()

@property(nonatomic, strong) NSMutableArray<QMUIButton *> *buttons;

@end

@implementation ZZFormRowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttons = [NSMutableArray array];
        [self initSubviews];
    }
    return self;
}

- (QMUIButton *)createButton {
    QMUIButton *button = [[QMUIButton alloc] initForAutoLayout];
    button.titleLabel.font = UIFont.qd_descriptionTextFont;
    button.backgroundColor = UIColorWhite;
    button.userInteractionEnabled = NO;
    [self addSubview:button];
    return button;
}

- (void)updateUIWith:(ZZFormRowModel *)rowModel {
    [self updateUIWith:rowModel toItemIndex:rowModel.items.count];
}

- (void)updateUIWith:(ZZFormRowModel *)rowModel toItemIndex:(NSInteger)toItemIndex {
    for(int i=0;i<toItemIndex;i++) {
        ZZFormItemModel *item = rowModel.items[i];
        QMUIButton *button;
        if (i<self.buttons.count) {
            button = self.buttons[i];
        } else {
            button = [self createButton];
            [self.buttons addObject:button];
        }
        
        [button setBackgroundColor:item.backgroundColor];
        [button setTitleColor:item.textColor forState:UIControlStateNormal];
        button.contentEdgeInsets = item.contentPadding;
        [button setTitle:item.content forState:UIControlStateNormal];
        [button setImage:item.accessoryImage forState:UIControlStateNormal];
        
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).inset(rowModel.isFirstRow ? PixelOne : 0);
            make.bottom.equalTo(self.mas_bottom).inset(PixelOne);
            make.width.equalTo(@(item.itemWidth - (i == 0 ? 2 : 1) * PixelOne));
        }];
        
        if (i == 0) {
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).inset(PixelOne);
            }];
        } else {
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.buttons[i-1].mas_right).offset(PixelOne);
            }];
        }
        
        if (i == toItemIndex-1) {
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).inset(PixelOne);
            }];
        }
    }
}

- (void)updateUIWithItem:(ZZFormItemModel *)itemModel atIndex:(NSInteger)index {
    if (index < self.buttons.count) {
        QMUIButton *button = self.buttons[index];
        [button setBackgroundColor:itemModel.backgroundColor];
        [button setTitleColor:itemModel.textColor forState:UIControlStateNormal];
        button.contentEdgeInsets = itemModel.contentPadding;
        [button setTitle:itemModel.content forState:UIControlStateNormal];
        [button setImage:itemModel.accessoryImage forState:UIControlStateNormal];
    }
}

- (void)initSubviews {
    self.backgroundColor = UIColor.qd_separatorColor;
    [self autoSetDimension:ALDimensionHeight toSize:SS(32) relation:NSLayoutRelationGreaterThanOrEqual];
}

@end
