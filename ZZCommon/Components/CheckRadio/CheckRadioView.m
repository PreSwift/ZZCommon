//
//  CheckRadioView.m

//  Created by mac on 2022/2/8.
//

#import "CheckRadioView.h"
#import "CheckRadioItem.h"
#import "ZZCommonMacros.h"

@interface CheckRadioView ()

@property(nonatomic, assign, readonly) int singleSelectedIndex;
@property(nonatomic, strong) NSArray<CheckRadioModel *> *items;

/**
 选项视图
 */
@property(nonatomic, strong) NSArray<CheckRadioItem *> *itemViews;

/**
 约束
 */
@property(nonatomic, strong) NSArray<NSArray<NSLayoutConstraint *> *> *itemViewsConstraints;

@end

@implementation CheckRadioView

- (void)dealloc {
    NSLog(@"%@", self);
}

- (instancetype)initWithItems:(NSArray<CheckRadioModel *> *)items
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.items = items;
        [self initSubviews];
        
        self.allowMutableCheck = NO;//默认不支持多选
        self.axis = UILayoutConstraintAxisHorizontal; //默认横向排列
        self.qmui_outsideEdge = UIEdgeInsetsMake(-16, -16, -16, -16);
    }
    return self;
}

- (void)initSubviews {
    NSMutableArray *itemViews = [NSMutableArray arrayWithCapacity:_items.count];
    __weak __typeof(self)weakSelf = self;
    for (int i=0;i<_items.count;i++) {
        CheckRadioModel *item = _items[i];
        CheckRadioItem *itemView = [[CheckRadioItem alloc] initWithModel:item];
        itemView.inputBlock = ^(CheckRadioItem * _Nonnull item, NSString * _Nonnull inputValue) {
            if (weakSelf.inputBlock) {
                weakSelf.inputBlock((int)item.tag, inputValue);
            }
        };
        itemView.selected = item.isSelected;
        itemView.tag = i;
        itemView.userInteractionEnabled = YES;
        [itemView addTarget:self action:@selector(tapItemView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemView];
        [itemViews addObject:itemView];
    }
    self.itemViews = itemViews;
    [self changeInputEnable];
}

- (void)setAxis:(UILayoutConstraintAxis)axis {
    _axis = axis;
    for (NSArray<NSLayoutConstraint *> *items in _itemViewsConstraints) {
        for (NSLayoutConstraint *item in items) {
            [item autoRemove];
        }
    }
    NSMutableArray *itemViewsConstraints = [NSMutableArray arrayWithCapacity:_itemViews.count];
    for (int i=0; i<_itemViews.count; i++) {
        CheckRadioItem *itemView = _itemViews[i];
        itemView.qmui_outsideEdge = UIEdgeInsetsMake(-16, -16, -16, -16);
        NSMutableArray *itemViewConstraints = [NSMutableArray arrayWithCapacity:12];
        if (i==0) {
            [itemViewConstraints addObject: [itemView autoPinEdgeToSuperviewEdge:ALEdgeTop]];
            [itemViewConstraints addObject: [itemView autoPinEdgeToSuperviewEdge:ALEdgeLeft]];
            if (_axis == UILayoutConstraintAxisVertical) {
                [itemViewConstraints addObject: [itemView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(15) relation:NSLayoutRelationGreaterThanOrEqual]];
            }
        } else {
            if (_axis == UILayoutConstraintAxisHorizontal) {
                [itemViewConstraints addObject: [itemView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_itemViews.firstObject]];
                [itemViewConstraints addObject: [itemView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_itemViews[i-1] withOffset:SS(35)]];
            } else {
                [itemViewConstraints addObject: [itemView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_itemViews.firstObject]];
                [itemViewConstraints addObject: [itemView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_itemViews[i-1] withOffset:SS(15)]];
                [itemViewConstraints addObject: [itemView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(15) relation:NSLayoutRelationGreaterThanOrEqual]];
            }
            if (i==_itemViews.count-1) {
                [itemViewConstraints addObject: [itemView autoPinEdgeToSuperviewEdge:ALEdgeBottom]];
                if (_axis == UILayoutConstraintAxisHorizontal) {
                    [NSLayoutConstraint autoSetPriority:800 forConstraints:^{
                        [itemViewConstraints addObject: [itemView autoPinEdgeToSuperviewEdge:ALEdgeRight]];
                    }];
                }
            }
        }
        [itemViewsConstraints addObject:itemViewConstraints];
    }
    self.itemViewsConstraints = itemViewsConstraints;
}

- (void)tapItemView:(CheckRadioItem *)itemView {
    if (!_allowMutableCheck) {
        itemView.model.isSelected = YES;
        [itemView setSelected:YES];
        for (CheckRadioItem *view in self.itemViews) {
            if (view != itemView) {
                view.model.isSelected = NO;
                [view setSelected:NO];
            }
        }
        if (self.checkBlock) {
            self.checkBlock(self.singleSelectedIndex);
        }
    } else {
        itemView.model.isSelected = !itemView.model.isSelected;
        [itemView setSelected:itemView.model.isSelected];
    }
    [self changeInputEnable];
}

- (void)changeInputEnable {
    __weak __typeof(self)weakSelf = self;
    [self.itemViews enumerateObjectsUsingBlock:^(CheckRadioItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == weakSelf.singleSelectedIndex) {
            obj.contentTextField.enabled = YES;
        } else {
            obj.contentTextField.enabled = NO;
        }
    }];
}

- (int)singleSelectedIndex {
    int index = -1;
    for (int i=0;i<self.itemViews.count;i++) {
        CheckRadioItem *itemView = self.itemViews[i];
        if (itemView.model.isSelected) {
            index = i;
            break;
        }
    }
    return index;
}

- (void)clearInput {
    [_itemViews enumerateObjectsUsingBlock:^(CheckRadioItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj clearInput];
    }];
}

- (void)clearInputWithOutCurrent {
    __weak __typeof(self)weakSelf = self;
    [_itemViews enumerateObjectsUsingBlock:^(CheckRadioItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != weakSelf.singleSelectedIndex) {
            [obj clearInput];
        }
    }];
}

@end
