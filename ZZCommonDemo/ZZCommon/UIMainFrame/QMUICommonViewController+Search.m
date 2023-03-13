//
//  QMUICommonViewController+Search.m
//  jzjx
//
//  Created by mac on 2022/3/24.
//

#import "QMUICommonViewController+Search.h"

@interface QMUICommonViewController (Search)<UISearchBarDelegate>

@property(nonatomic, strong) UIView *searchTitleView;
@property(nonatomic, strong) QMUISearchBar *searchBar;

@end

@implementation QMUICommonViewController (Search)


- (void)setKeyword:(NSString *)keyword {
    objc_setAssociatedObject(self, @selector(keyword), keyword, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)keyword {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSearchBlock:(void (^)(void))searchBlock {
    objc_setAssociatedObject(self, @selector(searchBlock), searchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))searchBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSearchTitleView:(UIView *)searchTitleView {
    objc_setAssociatedObject(self, @selector(searchTitleView), searchTitleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)searchTitleView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSearchBar:(QMUISearchBar *)searchBar {
    objc_setAssociatedObject(self, @selector(searchBar), searchBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (QMUISearchBar *)searchBar {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIBarButtonItem *)makeSearchButtonItem {
    self.searchTitleView = [[UIView alloc] initForAutoLayout];
    
    self.searchBar = [[QMUISearchBar alloc] init];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.qmui_alwaysEnableCancelButton = YES;
    self.searchBar.delegate = self;
    [self.searchTitleView addSubview:self.searchBar];
    [self.searchBar autoPinEdgesToSuperviewEdges];
    
    return [[UIBarButtonItem alloc] initWithImage:UIImageMake(@"搜索小") style:UIBarButtonItemStylePlain target:self action:@selector(toSearch)];
}

- (void)toSearch {
    self.navigationItem.titleView = self.searchTitleView;
    [self.searchBar becomeFirstResponder];
    self.searchBar.text = self.keyword;
    [self.searchTitleView.rightAnchor constraintEqualToAnchor:self.navigationController.navigationBar.rightAnchor constant:-12].active = YES;
}

- (void)cancelSearch {
    self.navigationItem.titleView = nil;
}

#pragma mark - <UISearchBarDelegate>

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (self.keyword && self.keyword.length > 0) {
        searchBar.text = nil;
        [self searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.navigationItem.titleView = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.keyword = searchBar.text;
    if (self.searchBlock) {
        self.searchBlock();
    }
}

@end
