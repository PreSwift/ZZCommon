//
//  PopupMenuView.h

//  Created by mac on 2022/3/11.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopupMenuButton<T:NSObject *> : QMUIButton

/**
 是否应用菜单文本到按钮，默认YES
 */
@property(nonatomic, assign) BOOL shouldAllowMenuTextToTitle;

/**
 菜单选择回调
 */
@property(nonatomic, copy, nullable) void(^selectBlock)(int selectedIndex, T _Nullable selectedValueObj);

/**
 设置菜单
 */
- (void)setValueObjs:(NSArray<T> * _Nullable)valueObjs nameBlock:(NSString *(^)(T valueObj))nameBlock;

/**
 设置菜单
 */
- (void)setValueObjs:(NSArray<T> * _Nullable)valueObjs defaultIndex:(int)defaultIndex nameBlock:(NSString *(^)(T valueObj))nameBlock;

/**
 设置菜单
 */
- (void)setValueObjs:(NSArray<T> * _Nullable)valueObjs defaultIndex:(int)defaultIndex nameBlock:(NSString *(^)(T valueObj))nameBlock imageBlock:(nullable UIImage *(^)(T valueObj))imageBlock;

/**
 清除菜单
 */
- (void)clearValueObjs;






/**
 弹窗视图
 */
@property(nonatomic, strong, readonly) QMUIPopupMenuView *menuView;

/**
 选中项
 */
@property(nonatomic, assign, readonly) int selectedIndex;

/**
 菜单项
 */
@property(nonatomic, strong, readonly, nullable) NSArray<T> *valueObjs;

/**
 快捷获取当前值
 */
@property(nonatomic, strong, readonly, nullable) T selectedValueObj;

@end

NS_ASSUME_NONNULL_END
