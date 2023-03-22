//
//  PopupMenuView.m

//  Created by mac on 2022/3/11.
//

#import "PopupMenuButton.h"
#import "ZZCommonMacros.h"

@interface PopupMenuButton<T:NSObject *> ()

/**
 选中项
 */
@property(nonatomic, assign) int tempSelectedIndex;

/**
 菜单项
 */
@property(nonatomic, strong, nullable) NSArray<T> *menuItems;

/**
 弹窗视图
 */
@property(nonatomic, strong) QMUIPopupMenuView *thisMenuView;

@end

@implementation PopupMenuButton

- (void)dealloc {
    NSLog(@"%@", self);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.shouldAllowMenuTextToTitle = YES;
        [self handleTapBlock];
        [self addPopupMenuView];
    }
    return self;
}

- (void)handleTapBlock {
    __weak __typeof(self)weakSelf = self;
    self.qmui_tapBlock = ^(__kindof UIControl *sender) {
        if (weakSelf.menuItems && weakSelf.menuItems.count > 0) {
            [weakSelf.menuView showWithAnimated:YES];
        } else {
            [ZZUITips showError:@"没有选项数据" inView:weakSelf.qmui_viewController.view];
        }
    };
}

- (void)addPopupMenuView {
    self.thisMenuView = [[QMUIPopupMenuView alloc] init];
    self.thisMenuView.automaticallyHidesWhenUserTap = YES; // 点击空白地方消失浮层
    self.thisMenuView.preferLayoutDirection = QMUIPopupContainerViewLayoutDirectionBelow;
    self.thisMenuView.itemTitleColor = UIColor.qd_mainTextColor;
    self.thisMenuView.itemTitleFont = CodeFontMake(SS(12));
    self.thisMenuView.maskViewBackgroundColor = [UIColor.blackColor colorWithAlphaComponent:.15];// 使用方法 2 并且打开了 automaticallyHidesWhenUserTap 的情况下，可以修改背景遮罩的颜色
    self.thisMenuView.shouldShowItemSeparator = YES;
    self.thisMenuView.sourceView = self;
}

- (QMUIPopupMenuView *)menuView {
    return self.thisMenuView;
}

- (void)setValueObjs:(NSArray *)valueObjs nameBlock:(NSString * _Nonnull (^)(NSObject * _Nonnull))nameBlock {
    [self setValueObjs:valueObjs defaultIndex:0 nameBlock:nameBlock];
}

- (void)setValueObjs:(NSArray *)valueObjs defaultIndex:(int)defaultIndex nameBlock:(NSString * _Nonnull (^)(NSObject * _Nonnull))nameBlock {
    [self setValueObjs:valueObjs defaultIndex:defaultIndex nameBlock:nameBlock imageBlock:nil];
}

- (void)setValueObjs:(NSArray *)valueObjs defaultIndex:(int)defaultIndex nameBlock:(NSString * _Nonnull (^)(NSObject * _Nonnull))nameBlock imageBlock:(UIImage * _Nonnull (^)(NSObject * _Nonnull))imageBlock {
    if (!valueObjs || valueObjs.count == 0 || defaultIndex >= valueObjs.count) {
        [self clearValueObjs];
        return;
    }
    _menuItems = valueObjs;
    self.tempSelectedIndex = defaultIndex;
    if (self.shouldAllowMenuTextToTitle) {
        [self setTitle:nameBlock(valueObjs[defaultIndex]) forState:UIControlStateNormal];
    }
    __weak __typeof(self)weakSelf = self;
    self.thisMenuView.items = [valueObjs qmui_mapWithBlock:^id _Nonnull(id  _Nonnull item) {
        QMUIPopupMenuButtonItem *buttonItem = [QMUIPopupMenuButtonItem itemWithImage:imageBlock ? imageBlock(item) : nil title:nameBlock(item) handler:^(QMUIPopupMenuButtonItem *aItem) {
            [aItem.menuView hideWithAnimated:YES];
            int tempSelectedIndex = (int)[weakSelf.thisMenuView.items indexOfObject:aItem];
            weakSelf.tempSelectedIndex = tempSelectedIndex;
            if (weakSelf.shouldAllowMenuTextToTitle) {
                [weakSelf setTitle:nameBlock(item) forState:UIControlStateNormal];
            }
            if (weakSelf.selectBlock) {
                weakSelf.selectBlock(weakSelf.tempSelectedIndex, weakSelf.selectedValueObj);
            }
        }];
        return buttonItem;
    }];
}

- (void)clearValueObjs {
    self.tempSelectedIndex = 0;
    if (self.shouldAllowMenuTextToTitle) {
        [self setTitle:nil forState:UIControlStateNormal];
    }
    self.thisMenuView.items = nil;
    _menuItems = nil;
}

- (int)selectedIndex {
    return _tempSelectedIndex;
}

- (NSArray *)valueObjs {
    return _menuItems;
}

- (id)selectedValueObj {
    if (_menuItems == nil || _tempSelectedIndex >= _menuItems.count) {
        return nil;
    }
    return _menuItems[_tempSelectedIndex];
}

@end
