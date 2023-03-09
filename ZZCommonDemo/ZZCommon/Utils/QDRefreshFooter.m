//
//  QDRefreshFooter.m
//  jzjx
//
//  Created by mac on 2022/7/12.
//

#import "QDRefreshFooter.h"

@implementation QDRefreshFooter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stateLabel.font = UIFont.qd_mainTextFont;
        self.stateLabel.textColor = UIColor.qd_descriptionTextColor;
        self.labelLeftInset = 0;
        [self setTitle:[self noMoreDataTitle] forState:MJRefreshStateNoMoreData];
        [self setTitle:@"" forState:MJRefreshStateIdle];
        [self setTitle:@"" forState:MJRefreshStatePulling];
        [self setTitle:@"" forState:MJRefreshStateRefreshing];
    }
    return self;
}

- (NSString *)noMoreDataTitle {
    return @"没有更多了";
}

@end
