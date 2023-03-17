//
//  ZZFilterRow.h

//  Created by mac on 2022/8/10.
//

#import <Foundation/Foundation.h>
#import "ZZCommonMacros.h"

#define TitleHeight SS(22)
#define SpaceTitle Spaceing(5)
#define ItemLineSeSpace SS(9)
#define ItemCoorSeSpace SS(20)
#define ItemCellHeight SS(34)

NS_ASSUME_NONNULL_BEGIN

@interface ZZFilterRow : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSArray<IDNameModel *> *items;
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, assign) NSInteger historySelectedIndex;
@property(nonatomic, assign) NSInteger columnCount;
@property(nonatomic, assign) CGFloat itemWidth;

- (instancetype)initWithTitle:(NSString *)title
                        items:(NSArray<IDNameModel *> *)items
                selectedIndex:(NSInteger)selectedIndex
                  columnCount:(NSInteger)columnCount;

- (void)saveHistory;
- (IDNameModel *)getSelectedItem;

@end

NS_ASSUME_NONNULL_END
