//
//  QMUICommonViewController+EmptyView.m

//  Created by mac on 2022/3/25.
//

#import "QMUICommonViewController+EmptyView.h"

@implementation QMUICommonViewController (EmptyView)

- (void)showEmptyViewWithEmpty {
    [self showEmptyViewWithImage:[UIImage imageNamed:@"default page_no content"] text:nil detailText:@"暂无内容，去其他地方看看吧～" buttonTitle:nil buttonAction:nil];
    self.emptyView.imageViewInsets = UIEdgeInsetsMake(0, 0, SS(10), 0);
}

- (void)showEmptyViewWithError {
    [self showEmptyViewWithImage:[UIImage imageNamed:@"default page_no network"] text:nil detailText:@"服务器请求错误，请稍后再试" buttonTitle:nil buttonAction:nil];
    self.emptyView.imageViewInsets = UIEdgeInsetsMake(0, 0, SS(10), 0);
}

@end
