//
//  ZZCommonViewController.m
//

#import "ZZCommonViewController.h"

@implementation ZZCommonViewController

- (void)initSubviews {
    [super initSubviews];
    self.emptyView.userInteractionEnabled = NO;
}

- (BOOL)shouldHideKeyboardWhenTouchInView:(UIView *)view {
    return YES;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

@end
