//
//  ZZFormRowView.m
//  teacher
//
//  Created by mac on 2023/2/13.
//

#import "ZZFormRowView.h"

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
    __weak __typeof(self)weakSelf = self;
    button.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (weakSelf.tapCellBlock) {
            weakSelf.tapCellBlock(sender.tag, sender);
        }
    };
    [self.buttons addObject:button];
    return button;
}

- (void)updateUIWith:(ZZFormRowModel *)rowModel {
    [self updateUIWith:rowModel toItemIndex:rowModel.items.count];
}

- (void)updateUIWith:(ZZFormRowModel *)rowModel toItemIndex:(NSInteger)toItemIndex {
    for (NSInteger i=_buttons.count-1; i>=0; i--) {
        if (i>toItemIndex-1) {
            QMUIButton *btn = _buttons[i];
            if (btn.superview != nil) {
                [btn removeFromSuperview];
            }
        }
    }
    for (int i=0; i<toItemIndex; i++) {
        QMUIButton *button;
        if (i<_buttons.count) {
            button = _buttons[i];
            if (button.superview == nil) {
                [self addSubview:button];
            }
        } else {
            button = [self createButton];
            [self addSubview:button];
        }
        ZZFormItemModel *item = rowModel.items[i];
        if (item.textAlignment == NSTextAlignmentLeft) {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        } else if (item.textAlignment == NSTextAlignmentLeft) {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        } else {
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.userInteractionEnabled = item.tapCellEnabled;
        button.titleLabel.numberOfLines = item.numberOfLines;
        button.imagePosition = item.accessoryImagePosition;
        [button setBackgroundColor:item.backgroundColor];
        [button setTitleColor:item.textColor forState:UIControlStateNormal];
        button.contentEdgeInsets = item.contentPadding;
        if (item.attributedContent) {
            [button setTitle:nil forState:UIControlStateNormal];
            [button setAttributedTitle:item.attributedContent forState:UIControlStateNormal];
        } else {
            [button setAttributedTitle:nil forState:UIControlStateNormal];
            [button setTitle:item.content forState:UIControlStateNormal];
        }
        [button setImage:item.accessoryImage forState:UIControlStateNormal];
        button.tag = i;
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).inset(rowModel.isFirstRow ? PixelOne : 0);
            make.bottom.equalTo(self.mas_bottom).inset(PixelOne).priorityHigh();
            if (i == 0) {
                make.left.equalTo(self.mas_left).inset(PixelOne);
            } else {
                make.left.equalTo(self.buttons[i-1].mas_right).offset(PixelOne);
            }
            if (i == toItemIndex-1) {
                make.right.equalTo(self.mas_right).inset(PixelOne);
                make.width.equalTo(@(item.itemWidth - (i == 0 ? 2 : 1) * PixelOne)).priorityLow();
            } else {
                make.width.equalTo(@(item.itemWidth - (i == 0 ? 2 : 1) * PixelOne));
            }
        }];
    }
}

- (void)updateUIWithItem:(ZZFormItemModel *)itemModel atIndex:(NSInteger)index {
    if (index < self.buttons.count) {
        QMUIButton *button = self.buttons[index];
        [button setBackgroundColor:itemModel.backgroundColor];
        [button setTitleColor:itemModel.textColor forState:UIControlStateNormal];
        button.contentEdgeInsets = itemModel.contentPadding;
        if (itemModel.attributedContent) {
            [button setTitle:nil forState:UIControlStateNormal];
            [button setAttributedTitle:itemModel.attributedContent forState:UIControlStateNormal];
        } else {
            [button setAttributedTitle:nil forState:UIControlStateNormal];
            [button setTitle:itemModel.content forState:UIControlStateNormal];
        }
        [button setImage:itemModel.accessoryImage forState:UIControlStateNormal];
    }
}

- (void)initSubviews {
    self.backgroundColor = UIColor.qd_separatorColor;
    [self autoSetDimension:ALDimensionHeight toSize:SS(32) relation:NSLayoutRelationGreaterThanOrEqual];
}

@end
