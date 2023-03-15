//
//  QDFilterRow.m
//  jzjx
//
//  Created by mac on 2022/8/10.
//

#import "QDFilterRow.h"

@implementation QDFilterRow

- (instancetype)initWithTitle:(NSString *)title items:(NSArray<IDNameModel *> *)items selectedIndex:(NSInteger)selectedIndex columnCount:(NSInteger)columnCount {
    self = [super init];
    if (self) {
        _title = title;
        _items = items;
        _selectedIndex = selectedIndex;
        _historySelectedIndex = selectedIndex;
        _columnCount = columnCount;
        _itemWidth = floorf((SCREEN_WIDTH - Spaceing(8) - (columnCount - 1) * ItemLineSeSpace) / columnCount);
    }
    return self;
}

- (void)saveHistory {
    _historySelectedIndex = _selectedIndex;
}

- (IDNameModel *)getSelectedItem {
    return _items[_selectedIndex];
}

@end
