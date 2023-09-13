//
//  ZZFormRowModel.m
//  jzjx
//
//  Created by Ethan on 2022/9/28.
//

#import "ZZFormRowModel.h"
#import "ZZCommonMacros.h"

@implementation ZZFormRowModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSAssert(0, @"请使用初始化方法initWithItems:");
    }
    return self;
}

- (instancetype)initWithItems:(NSArray<ZZFormItemModel *> *)items {
    self = [super init];
    if (self) {
        _items = items;
        _selectionStyle = UITableViewCellSelectionStyleNone;
        _selectedBackgroundColor = [UIColor.qd_backgroundColorHighlighted colorWithAlphaComponent:0.5];
        __block CGFloat maxHeight = 0;
        [items enumerateObjectsUsingBlock:^(ZZFormItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.itemHeight > maxHeight) {
                maxHeight = obj.itemHeight;
            }
        }];
        _rowHeight = maxHeight;
    }
    return self;
}

@end
