//
//  UIScrollView+RequestPageExtension.m

//  Created by westMac on 2021/10/28.
//

#import "UIScrollView+RequestPageExtension.h"
#import <objc/runtime.h>
#import "ZZCommonMacros.h"

@interface UIScrollView (RequestPageExtension)

@property(nonatomic, strong) NSNumber *currentPage;
@property(nonatomic, strong) UIColor *oldBackgroundColor;

@end

@implementation UIScrollView (RequestPageExtension)

- (void)setCurrentPage:(NSNumber *)currentPage {
    objc_setAssociatedObject(self, "currentPage", currentPage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)currentPage {
    return objc_getAssociatedObject(self, "currentPage");
}

- (void)setOldBackgroundColor:(UIColor *)oldBackgroundColor {
    objc_setAssociatedObject(self, "oldBackgroundColor", oldBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)oldBackgroundColor {
    return objc_getAssociatedObject(self, "oldBackgroundColor");
}

- (int)page {
    return self.currentPage.intValue;
}

- (void)addRefreshView:(BOOL)refreshFirst refreshBlock:(void (^)(void))refreshBlock {
    [self addMJFooter:refreshBlock];
    [self addMJHeader:refreshFirst refreshBlock:refreshBlock];
}

- (void)addRefreshViewWithOutFooter:(BOOL)refreshFirst refreshBlock:(void (^)(void))refreshBlock {
    [self addMJHeader:refreshFirst refreshBlock:refreshBlock];
}

- (void)addMJHeader:(BOOL)refreshFirst refreshBlock:(void (^)(void))refreshBlock {
    __weak __typeof(self)weakSelf = self;
    ZZRefreshHeader *header = [ZZRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = @1;
        refreshBlock();
        if (weakSelf.mj_footer) {
            [weakSelf.mj_footer setState:MJRefreshStateIdle];
        }
    }];
    self.mj_header = header;
    
    self.currentPage = @1;
    if (refreshFirst) {
        [(QMUICommonViewController *)self.qmui_viewController showEmptyViewWithLoading];
        refreshBlock();
    }
    self.oldBackgroundColor = self.backgroundColor;
}

- (void)addMJFooter:(void (^)(void))refreshBlock {
    ZZRefreshFooter *footer = [ZZRefreshFooter footerWithRefreshingBlock:^{
        refreshBlock();
    }];
    self.mj_footer = footer;
}

- (void)resetPage {
    self.currentPage = @1;
}

- (void)begainRefreshing {
    if (self.mj_header != nil) {
        [self.mj_header beginRefreshing];
    }
}

- (void)endRefreshing:(BOOL)noMoreData {
    if (self.mj_header != nil) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer != nil) {
        if (noMoreData) {
            [self.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.mj_footer endRefreshing];
        }
    }
}

- (void)handleSuccessWithSection:(NSInteger)section data:(NSMutableArray *)originalData addData:(NSArray *)additionalData total:(NSInteger)total {
    if (self.page == 1) {
        [originalData removeAllObjects];
        if (additionalData != nil && additionalData.count > 0) {
            [originalData addObjectsFromArray:additionalData];
        }
        if ([self isKindOfClass:UITableView.class]) {
            [(UITableView *)self reloadData];
        } else if ([self isKindOfClass:UICollectionView.class]) {
            [(UICollectionView *)self reloadData];
        }
    } else {
        if (additionalData != nil && additionalData.count > 0) {
            NSInteger currentRow = originalData.count;
            [originalData addObjectsFromArray:additionalData];
            if ([self isKindOfClass:UITableView.class]) {
                NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:additionalData.count];
                for (int i=0;i<additionalData.count;i++) {
                    [indexPaths addObject:[NSIndexPath indexPathForRow:currentRow + i inSection:section]];
                }
                UITableView *tableView = (UITableView *)self;
                [tableView beginUpdates];
                [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                [tableView endUpdates];
            } else if ([self isKindOfClass:UICollectionView.class]) {
                NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:additionalData.count];
                for (int i=0;i<additionalData.count;i++) {
                    [indexPaths addObject:[NSIndexPath indexPathForItem:currentRow + i inSection:section]];
                }
                UICollectionView *collectionView = (UICollectionView *)self;
                [collectionView insertItemsAtIndexPaths:indexPaths];
            }
        }
    }
    
    if (total > originalData.count) {
        self.currentPage = @(self.page + 1);
        [self endRefreshing:NO];
    } else {
        [self endRefreshing:YES];
    }
    
    [self resetFooterTitle:total <= 0];
    
    if (originalData.count==0) {
        [(QMUICommonViewController *)self.qmui_viewController showEmptyViewWithEmpty];
        self.backgroundColor = UIColor.whiteColor;
    } else {
        [(QMUICommonViewController *)self.qmui_viewController hideEmptyView];
        self.backgroundColor = self.oldBackgroundColor;
    }
}

- (void)handleFail:(BOOL)isEmpty responseMsg:(NSString *)responseMsg {
    [self endRefreshing:self.page == 1];
    [self resetFooterTitle:isEmpty];
    
    if (isEmpty) {
        [(QMUICommonViewController *)self.qmui_viewController showEmptyViewWithError];
        self.backgroundColor = UIColor.whiteColor;
    } else {
        [(QMUICommonViewController *)self.qmui_viewController hideEmptyView];
        self.backgroundColor = self.oldBackgroundColor;
        [ZZUITips showWithText:responseMsg inView:self.qmui_viewController.view];
    }
}

- (void)resetFooterTitle:(BOOL)isEmpty {
    ZZRefreshFooter *footer = (ZZRefreshFooter *)self.mj_footer;
    if (footer) {
        if (isEmpty) {
            [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
        } else {
            [footer setTitle:[footer noMoreDataTitle] forState:MJRefreshStateNoMoreData];
        }
    }
}

@end
