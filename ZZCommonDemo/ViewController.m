//
//  ViewController.m
//  ZZCommonDemo
//
//  Created by mac on 2023/3/15.
//

#import "ViewController.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"首页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"横屏" style:UIBarButtonItemStylePlain target:self action:@selector(toH)];
}

- (void)toH {
    ViewController2 *vc = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorWhite;
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initForAutoLayout];
    [self.view addSubview:scrollView];
    [scrollView autoPinEdgesToSuperviewEdges];
    
    UIView *view1 = [[UIView alloc] initForAutoLayout];
    view1.backgroundColor = UIColor.redColor;
    [scrollView addSubview:view1];
    [view1 autoSetDimensionsToSize:CGSizeMake(40, 300)];
    [view1 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [view1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [view1 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    UIScrollView *scView = [[UIScrollView alloc] initForAutoLayout];
    scView.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.3];
    [scrollView addSubview:scView];
    [scView autoSetDimensionsToSize:CGSizeMake(SCREEN_WIDTH, 500)];
    [scView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [scView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:view1];
    [scView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    
    UIView *ftBview = [[UIView alloc] initForAutoLayout];
    ftBview.backgroundColor = UIColor.greenColor;
    [scView addSubview:ftBview];
    [ftBview autoSetDimensionsToSize:CGSizeMake(SCREEN_WIDTH, 40)];
    [ftBview autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [ftBview autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [ftBview autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:100];
    
    UIView *view2 = [[UIView alloc] initForAutoLayout];
    view2.backgroundColor = UIColor.redColor;
    [scrollView addSubview:view2];
    [view2 autoSetDimensionsToSize:CGSizeMake(40, 400)];
    [view2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [view2 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [view2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [view2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:scView];
}


@end
