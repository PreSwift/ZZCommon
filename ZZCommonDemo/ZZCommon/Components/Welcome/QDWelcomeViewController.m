//
//  QDWelcomeViewController.m
//  jzjx
//
//  Created by mac on 2022/6/21.
//

#import "QDWelcomeViewController.h"
#import "SDCycleScrollView.h"
#import "QDWelcomePageItem.h"
#import "QDTabBarViewController.h"

@interface QDWelcomeCollectionCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UILabel *label2;
@property(nonatomic, strong) QMUIButton *startBtn;

@end

@implementation QDWelcomeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = UIColorWhite;
    
    UIView *centerView = [[UIView alloc] initForAutoLayout];
    [self addSubview:centerView];
    [centerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [centerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [centerView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    _imageView = [[UIImageView alloc] initForAutoLayout];
    [centerView addSubview:_imageView];
    [_imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    _label1 = [[UILabel alloc] initForAutoLayout];
    _label1.font = CodeBoldFontMake(SS(21));
    _label1.textColor = UIColor.qd_titleTextColor;
    [centerView addSubview:_label1];
    [_label1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imageView withOffset:SS(30)];
    [_label1 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    _label2 = [[UILabel alloc] initForAutoLayout];
    _label2.font = CodeFontMake(SS(16));
    _label2.textColor = UIColorMakeWithHex(@"#CACBCF");
    [centerView addSubview:_label2];
    [_label2 autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_label2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_label1 withOffset:Spaceing(4)];
    [_label2 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    _startBtn = [[QMUIButton alloc] initForAutoLayout];
    _startBtn.titleLabel.font = UIFont.qd_titleMediumFont;
    [_startBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_startBtn setTitle:@"????????????" forState:UIControlStateNormal];
    _startBtn.cornerRadius = SS(23);
    _startBtn.backgroundColor = UIColor.qd_tintColor;
    [self.contentView addSubview:_startBtn];
    [_startBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_startBtn autoSetDimensionsToSize:CGSizeMake(SS(164), SS(46))];
    [_startBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SafeAreaInsetsConstantForDeviceWithNotch.bottom + SS(74)];
}

@end

@interface QDWelcomeViewController ()<SDCycleScrollViewDelegate>

@property(nonatomic, strong) SDCycleScrollView *cycleImageView;
@property(nonatomic, strong) NSArray<QDWelcomePageItem *> *items;

@end

@implementation QDWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)preferredNavigationBarHidden {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabBarController hideTabBar];
}

- (void)initSubviews {
    [super initSubviews];
    
    _cycleImageView = [[SDCycleScrollView alloc] initForAutoLayout];
    _cycleImageView.autoScroll = NO;
    _cycleImageView.infiniteLoop = NO;
    _cycleImageView.delegate = self;
    _cycleImageView.showPageControl = YES;
    _cycleImageView.pageControlBottomOffset = SafeAreaInsetsConstantForDeviceWithNotch.bottom;
    _cycleImageView.backgroundColor = UIColor.qd_imageViewBackgroundColor;
    _cycleImageView.placeholderImage = UIImageMake(@"????????????");
    _cycleImageView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_cycleImageView];
    [_cycleImageView autoPinEdgesToSuperviewEdges];
    
    [self setImageData];
}

- (void)setImageData {
    _items = @[
        [[QDWelcomePageItem alloc] initWithImageName:@"?????????-1" text1:@"???????????????????????????" text2:@"???????????????????????????"],
        [[QDWelcomePageItem alloc] initWithImageName:@"?????????-2" text1:@"???????????????????????????" text2:@"???????????????????????????"],
        [[QDWelcomePageItem alloc] initWithImageName:@"?????????-3" text1:@"???????????????????????????" text2:@"???????????????????????????"],
    ];
    _cycleImageView.localizationImageNamesGroup = [_items qmui_mapWithBlock:^id _Nonnull(QDWelcomePageItem * _Nonnull item) {
        return item.imageName;
    }];
    _cycleImageView.pageControl.currentColor = UIColor.qd_titleTextColor;
    _cycleImageView.pageControl.otherColor = UIColor.qd_descriptionTextColor;
}

#pragma mark - <SDCycleScrollViewDelegate>

- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return QDWelcomeCollectionCell.class;
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    QDWelcomeCollectionCell *thisCell = (QDWelcomeCollectionCell *)cell;
    if (thisCell.startBtn.allTargets.count == 0) {
        [thisCell.startBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    QDWelcomePageItem *item = _items[index];
    thisCell.imageView.image = UIImageMake(item.imageName);
    thisCell.label1.text = item.text1;
    thisCell.label2.text = item.text2;
    if (index == _items.count - 1) {
        thisCell.startBtn.hidden = NO;
    } else {
        thisCell.startBtn.hidden = YES;
    }
}

- (void)tapAction:(UIButton *)sender {
    NSString *currentVersion = [NSBundle mainBundle].appVersion;
    [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:@"localVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.changeVCToMainBlock();
}

@end
