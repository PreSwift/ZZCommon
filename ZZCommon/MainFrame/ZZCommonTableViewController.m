//
//  ZZCommonTableViewController.m
//

#import "ZZCommonTableViewController.h"

@implementation ZZCommonTableViewController

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

- (void)qmui_themeDidChangeByManager:(QMUIThemeManager *)manager identifier:(__kindof NSObject<NSCopying> *)identifier theme:(__kindof NSObject *)theme {
    [super qmui_themeDidChangeByManager:manager identifier:identifier theme:theme];
    [self.tableView reloadData];
}

@end
