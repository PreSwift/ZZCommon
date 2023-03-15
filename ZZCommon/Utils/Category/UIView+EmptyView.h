//
//  UIView+EmptyView.h

//  Created by mac on 2022/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (EmptyView)

@property(nonatomic, strong, readonly) QMUIEmptyView *emptyView;

- (void)initializeEmptyView;
- (void)showEmptyViewWithLoading;
- (void)showEmptyViewWithLoadingAndOffset:(CGFloat)offset;
- (void)showEmptyViewWithEmpty;
- (void)showEmptyViewWithEmptyAndOffset:(CGFloat)offset;
- (void)showEmptyViewWithText:(NSString *)text;
- (void)showEmptyViewWithText:(NSString *)text andOffset:(CGFloat)offset;
- (void)showEmptyViewWithError;
- (void)showEmptyViewWithErrorAndOffset:(CGFloat)offset;
- (void)showEmptyViewWithErrorButNoImage;
- (void)hideEmptyView;
- (BOOL)isEmptyViewShowing;

@end

NS_ASSUME_NONNULL_END
