//
//  ViewController.m
//  ZZCommonDemo
//
//  Created by mac on 2023/3/15.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"首页";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorWhite;
    // Do any additional setup after loading the view.
    
    QMUIButton *view = [[QMUIButton alloc] initForAutoLayout];
    view.cornerRadius = CornerRadius(1);
    view.backgroundColor = UIColor.qd_tintColor;
    view.titleLabel.font = UIFont.qd_titleFont;
    [view setTitle:@"我知道了" forState:UIControlStateNormal];
    [view setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [self.view addSubview:view];
    [view autoCenterInSuperview];
    [view autoSetDimensionsToSize:CGSizeMake(SS(200), SS(60))];
}


@end
