//
//  QMUICommonViewController+FixBackGesture.m
//  jzjx
//
//  Created by mac on 2022/3/24.
//

#import "QMUICommonViewController+FixBackGesture.h"

@interface QMUICommonViewController (FixBackGesture)<UIGestureRecognizerDelegate>

@property(nonatomic, strong) UISwipeGestureRecognizer *backSwiperGesture;

@end

@implementation QMUICommonViewController (FixBackGesture)

- (void)setBackSwiperGesture:(UISwipeGestureRecognizer *)backSwiperGesture {
    objc_setAssociatedObject(self, @selector(backSwiperGesture), backSwiperGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UISwipeGestureRecognizer *)backSwiperGesture {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)fixGestureGoBack {
    /**
     修复返回手势
     */
    if (self.backSwiperGesture == nil) {
        self.backSwiperGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
        self.backSwiperGesture.delegate = self;
        [self.view addGestureRecognizer: self.backSwiperGesture];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)handleNavigationTransition:(UISwipeGestureRecognizer *)gesture {
    
}

@end
