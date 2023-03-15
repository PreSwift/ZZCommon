//
//  CheckButton.h

//  Created by mac on 2022/5/7.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckButton : QMUIButton

@property(nonatomic, strong, readonly) NSArray<IDNameModel *> *checkItems;
@property(nonatomic, assign, readonly) NSInteger selectIndex;
@property(nonatomic, strong, readonly, nullable) IDNameModel *selectItem;
@property(nonatomic, strong) NSString *checkTitle;
@property(nonatomic, assign) BOOL isHideAccView;
@property(nonatomic, assign) NSInteger columnCount;
@property(nonatomic, assign) BOOL shouldLoadCheckBlockAtFirst;
@property(nonatomic, copy) void(^checkBlock)(IDNameModel * _Nullable item);

- (void)setCheckItems:(NSArray<IDNameModel *> *)checkItems selectIndex:(NSInteger)selectIndex;
- (void)setSelectIndex:(NSInteger)selectIndex;
- (void)showChecKWindow;
- (void)setMainColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
