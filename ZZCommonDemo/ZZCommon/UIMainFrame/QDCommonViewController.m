//
//  QDCommonViewController.m
//  qmuidemo
//
//  Created by QMUI Team on 15/4/13.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import "QDCommonViewController.h"

@implementation QDCommonViewController

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
