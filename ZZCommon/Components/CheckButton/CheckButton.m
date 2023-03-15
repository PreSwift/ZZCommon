//
//  CheckButton.m

//  Created by mac on 2022/5/7.
//

#import "CheckButton.h"

@interface CheckButtonCollectionItemCell : UICollectionViewCell

@property(nonatomic, strong) QMUIButton *button;

@end

@implementation CheckButtonCollectionItemCell

- (void)dealloc {
    NSLog(@"%@", self);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _button = [QDUIHelper generateGhostButton];
    _button.userInteractionEnabled = NO;
    [self.contentView addSubview:_button];
    [_button autoPinEdgesToSuperviewEdges];
}

- (void)updateWith:(IDNameModel *)model isSelected:(BOOL)isSelected {
    [_button setTitle:model.name forState:UIControlStateNormal];
    _button.selected = isSelected;
}

@end

@interface CheckButton()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UIImageView *rightBottomMarkView;
@property(nonatomic, strong) UILabel *mainTitleLabel;
@property(nonatomic, strong) QMUIModalPresentationViewController *modalViewController;
@property(nonatomic, strong) UICollectionView *collcetionView;
@property(nonatomic, assign) CGFloat itemWidth;

@end

@implementation CheckButton

- (void)setColumnCount:(NSInteger)columnCount {
    _columnCount = columnCount;
    _itemWidth = floor((SCREEN_WIDTH - Spaceing(8) - SS(9) * (columnCount - 1)) / columnCount);
}

- (void)setCheckTitle:(NSString *)checkTitle {
    _checkTitle = checkTitle;
    _mainTitleLabel.text = checkTitle;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _checkTitle = @"选择";
        self.shouldLoadCheckBlockAtFirst = YES;
        self.columnCount = 5;
        [self initSubviews];
    }
    return self;
}

- (void)setIsHideAccView:(BOOL)isHideAccView {
    _isHideAccView = isHideAccView;
    _rightBottomMarkView.hidden = isHideAccView;
}

- (void)initSubviews {
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, Spaceing(3));
    __weak __typeof(self)weakSelf = self;
    self.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [weakSelf showChecKWindow];
    };
    
    _rightBottomMarkView = [[UIImageView alloc] initForAutoLayout];
    _rightBottomMarkView.image = UIImageMake(@"drop-down_icon_default");
    [self addSubview:_rightBottomMarkView];
    [_rightBottomMarkView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_rightBottomMarkView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SS(372) + SafeAreaInsetsConstantForDeviceWithNotch.bottom)];
    contentView.backgroundColor = UIColor.whiteColor;
    contentView.layer.cornerRadius = Spaceing(4);
    contentView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
    
    UILabel *titleLabel = [[UILabel alloc] qmui_initWithFont:UIFont.qd_titleMediumFont textColor:UIColor.qd_titleTextColor];
    [titleLabel configureForAutoLayout];
    titleLabel.text = _checkTitle;
    [contentView addSubview:titleLabel];
    self.mainTitleLabel = titleLabel;
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:Spaceing(4)];
    
    UIButton *closeBtn = [[UIButton alloc] initForAutoLayout];
    [closeBtn setImage:[[UIImage imageNamed:@"关闭叉"] qmui_imageWithTintColor:UIColor.qd_titleTextColor] forState:UIControlStateNormal];
    closeBtn.qmui_outsideEdge = UIEdgeInsetsMake(-SS(10), -SS(10), -SS(10), -SS(10));
    [contentView addSubview:closeBtn];
    [closeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4)];
    [closeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:titleLabel];
    [closeBtn autoSetDimensionsToSize:CGSizeMake(SS(24), SS(24))];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = SS(20);
    flowLayout.minimumInteritemSpacing = SS(9);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, Spaceing(4), 0);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [collectionView registerClass:CheckButtonCollectionItemCell.class forCellWithReuseIdentifier:@"CheckButtonCollectionItemCell"];
    collectionView.backgroundColor = UIColorWhite;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.verticalScrollIndicatorInsets = UIEdgeInsetsMake(0, 0, Spaceing(4), 0);
    self.collcetionView = collectionView;
    [contentView addSubview:collectionView];
    [collectionView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:Spaceing(4)];
    [collectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4)];
    [collectionView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4)];
    
    UIView *line = [[UIView alloc] initForAutoLayout];
    line.backgroundColor = UIColor.qd_backgroundColorLighten;
    [contentView addSubview:line];
    [line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:collectionView];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [line autoSetDimension:ALDimensionHeight toSize:1];
    
    QMUIButton *cancelBtn = [[QMUIButton alloc] initForAutoLayout];
    cancelBtn.backgroundColor = UIColorMakeWithHex(@"#F4F4F4");
    cancelBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    cancelBtn.titleLabel.font = UIFont.qd_titleMediumFont;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColor.qd_mainTextColor forState:UIControlStateNormal];
    [contentView addSubview:cancelBtn];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(20) + SafeAreaInsetsConstantForDeviceWithNotch.bottom];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4)];
    [cancelBtn autoSetDimension:ALDimensionHeight toSize:SS(38)];
    [cancelBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line withOffset:SS(20)];
    
    QMUIButton *actionBtn = [[QMUIButton alloc] initForAutoLayout];
    actionBtn.backgroundColor = UIColor.qd_tintColor;
    actionBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    actionBtn.titleLabel.font = UIFont.qd_titleMediumFont;
    [actionBtn setTitle:@"确定" forState:UIControlStateNormal];
    [actionBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [contentView addSubview:actionBtn];
    [actionBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:cancelBtn];
    [actionBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4)];
    [actionBtn autoSetDimension:ALDimensionHeight toSize:SS(38)];
    [actionBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:cancelBtn withOffset:Spaceing(4)];
    [actionBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:cancelBtn];
    
    QMUIModalPresentationViewController *modalViewController = [[QMUIModalPresentationViewController alloc] init];
    modalViewController.contentViewMargins = UIEdgeInsetsZero;
    modalViewController.modal = YES;
    modalViewController.animationStyle = QMUIModalPresentationAnimationStyleSlide;
    modalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        contentView.qmui_frameApplyTransform = CGRectSetXY(contentView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(contentView.frame)),
                                                           CGRectGetHeight(containerBounds) - CGRectGetHeight(contentView.frame));
    };
    closeBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
    };
    cancelBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
    };
    actionBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        [modalViewController hideWithAnimated:YES completion:nil];
        IDNameModel *model = weakSelf.selectItem;
        [weakSelf setTitle:model.name forState:UIControlStateNormal];
        weakSelf.checkBlock(model);
    };
    modalViewController.contentView = contentView;
    _modalViewController = modalViewController;
}

- (void)showChecKWindow {
    if (self.checkItems.count > 0) {
        [self showCustomAlertModalView];
    }
}

- (void)setMainColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    self.rightBottomMarkView.image = [self.rightBottomMarkView.image qmui_imageWithTintColor:color];
}

- (void)setCheckItems:(NSArray<IDNameModel *> *)checkItems selectIndex:(NSInteger)selectIndex {
    _checkItems = checkItems;
    _selectIndex = selectIndex;
    if (checkItems.count > selectIndex) {
        [self setTitle:checkItems[selectIndex].name forState:UIControlStateNormal];
        if (self.shouldLoadCheckBlockAtFirst) {
            self.checkBlock(checkItems[selectIndex]);
        }
    } else {
        [self setTitle:nil forState:UIControlStateNormal];
        if (self.shouldLoadCheckBlockAtFirst) {
            self.checkBlock(nil);
        }
    }
    [_collcetionView reloadData];
}

- (IDNameModel *)selectItem {
    if (_selectIndex < _checkItems.count) {
        return _checkItems[_selectIndex];
    }
    return nil;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (_checkItems.count > selectIndex) {
        [self setTitle:_checkItems[selectIndex].name forState:UIControlStateNormal];
    } else {
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

- (void)showCustomAlertModalView {
    __weak __typeof(self)weakSelf = self;
    [_checkItems enumerateObjectsUsingBlock:^(IDNameModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:self.titleLabel.text]) {
            weakSelf.selectIndex = idx;
            *stop = YES;
        }
    }];
    [_collcetionView reloadData];
    [_modalViewController showWithAnimated:YES completion:nil];
}

#pragma mark - <UICollectionViewDataSource UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _checkItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CheckButtonCollectionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CheckButtonCollectionItemCell" forIndexPath:indexPath];
    IDNameModel *model = _checkItems[indexPath.item];
    [cell updateWith:model isSelected:_selectIndex == indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(_itemWidth, SS(34));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndex = indexPath.item;
    [collectionView reloadData];
}


@end
