//
//  UIView+EmptyView.m

//  Created by mac on 2022/3/22.
//

#import "UIView+EmptyView.h"

@interface UIView (EmptyView)

@property(nonatomic, strong) QMUIEmptyView *_emptyView;

@end

@implementation UIView (EmptyView)


- (void)set_emptyView:(QMUIEmptyView *)_emptyView {
    objc_setAssociatedObject(self, @selector(_emptyView), _emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QMUIEmptyView *)_emptyView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)initializeEmptyView {
    QMUIEmptyView *_emptyView = self._emptyView;
    if (_emptyView == nil) {
        _emptyView = [[QMUIEmptyView alloc] initForAutoLayout];
        _emptyView.imageViewInsets = UIEdgeInsetsMake(0, 0, Spaceing(4), 0);
        _emptyView.loadingViewInsets = UIEdgeInsetsMake(0, 0, Spaceing(4), 0);
        _emptyView.detailTextLabel.textColor = UIColor.qd_descriptionTextColor;
        _emptyView.detailTextLabelFont = UIFont.qd_mainTextFont;
        _emptyView.backgroundColor = UIColorClear;
        _emptyView.userInteractionEnabled = NO;
        [self addSubview:_emptyView];
        [_emptyView autoPinEdgesToSuperviewEdges];
        if ([self isKindOfClass:UIScrollView.class]) {
            [_emptyView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self];
            [_emptyView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];
        }
        self._emptyView = _emptyView;
    }
}

- (void)showEmptyViewWithLoading {
    [self initializeEmptyView];
    [self showEmptyViewWithLoadingAndOffset:0];
}

- (void)showEmptyViewWithLoadingAndOffset:(CGFloat)offset {
    [self initializeEmptyView];
    [self._emptyView setImage:nil];
    [self._emptyView setLoadingViewHidden:NO];
    [self._emptyView setTextLabelText:nil];
    [self._emptyView setDetailTextLabelText:nil];
    [self._emptyView setActionButtonTitle:nil];
    [self._emptyView setVerticalOffset:offset];
}

- (void)showEmptyViewWithEmpty {
    [self initializeEmptyView];
    [self showEmptyViewWithEmptyAndOffset:0];
}

- (void)showEmptyViewWithEmptyAndOffset:(CGFloat)offset {
    [self initializeEmptyView];
    [self._emptyView setImage:[UIImage imageNamed:@"default page_no content"]];
    [self._emptyView setLoadingViewHidden:YES];
    [self._emptyView setTextLabelText:nil];
    [self._emptyView setDetailTextLabelText:@"暂无内容，去其他地方看看吧～"];
    [self._emptyView setActionButtonTitle:nil];
    [self._emptyView setVerticalOffset:offset];
}

- (void)showEmptyViewWithText:(NSString *)text {
    [self initializeEmptyView];
    [self showEmptyViewWithText:text andOffset:0];
}

- (void)showEmptyViewWithText:(NSString *)text andOffset:(CGFloat)offset {
    [self initializeEmptyView];
    [self._emptyView setImage:nil];
    [self._emptyView setLoadingViewHidden:YES];
    [self._emptyView setTextLabelText:nil];
    [self._emptyView setDetailTextLabelText:text];
    [self._emptyView setActionButtonTitle:nil];
    [self._emptyView setVerticalOffset:offset];
}

- (void)showEmptyViewWithError {
    [self initializeEmptyView];
    [self showEmptyViewWithErrorAndOffset:0];
}

- (void)showEmptyViewWithErrorAndOffset:(CGFloat)offset {
    [self initializeEmptyView];
    [self._emptyView setImage:[UIImage imageNamed:@"default page_no network"]];
    [self._emptyView setLoadingViewHidden:YES];
    [self._emptyView setTextLabelText:nil];
    [self._emptyView setDetailTextLabelText:@"服务器请求错误，请稍后再试"];
    [self._emptyView setActionButtonTitle:nil];
    [self._emptyView setVerticalOffset:offset];
}

- (void)showEmptyViewWithErrorButNoImage {
    [self initializeEmptyView];
    [self showEmptyViewWithErrorButNoImageAndOffset:0];
}

- (void)showEmptyViewWithErrorButNoImageAndOffset:(CGFloat)offset {
    [self initializeEmptyView];
    [self._emptyView setImage:nil];
    [self._emptyView setLoadingViewHidden:YES];
    [self._emptyView setTextLabelText:nil];
    [self._emptyView setDetailTextLabelText:@"服务器请求错误，请稍后再试"];
    [self._emptyView setActionButtonTitle:nil];
    [self._emptyView setVerticalOffset:offset];
}

- (void)hideEmptyView {
    QMUIEmptyView *_emptyView = self._emptyView;
    if (_emptyView) {
        [_emptyView removeFromSuperview];
        self._emptyView = nil;
    }
}

- (QMUIEmptyView *)emptyView {
    return self._emptyView;
}

- (BOOL)isEmptyViewShowing {
    return self._emptyView && self._emptyView.superview;
}

@end

