//
//  QDFilterView.m

//  Created by mac on 2022/8/10.
//

#import "QDFilterView.h"

@interface QDFilterView () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, assign) CGFloat contentViewHeight;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) QMUIButton *cancelBtn;
@property(nonatomic, strong) QMUIButton *submitBtn;

@end

@implementation QDFilterView

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

- (void)setupFilterRows:(NSArray<QDFilterRow *> *)filterRows {
    _filterRows = filterRows;
}

- (void)initSubviews {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    self.contentViewHeight = SS(513);
    
    _contentView = [[UIView alloc] initForAutoLayout];
    _contentView.userInteractionEnabled = YES;
    _contentView.backgroundColor = UIColorWhite;
    _contentView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    _contentView.layer.cornerRadius = CornerRadius(4);
    _contentView.layer.masksToBounds = YES;
    [self addSubview:_contentView];
    [_contentView autoSetDimension:ALDimensionHeight toSize:_contentViewHeight];
    [_contentView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_contentView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_contentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:StatusBarHeight + NavigationBarHeight];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = ItemLineSeSpace;
    flowLayout.minimumLineSpacing = ItemCoorSeSpace;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, Spaceing(4), 0, Spaceing(4));
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:QDFilterItemCell.class forCellWithReuseIdentifier:@"QDFilterItemCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterTitle"];
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, Spaceing(4), 0);
    _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.contentView addSubview:_collectionView];
    [_collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    
    UIView *line = [[UIView alloc] initForAutoLayout];
    line.backgroundColor = UIColor.qd_backgroundColorLighten;
    [self.contentView addSubview:line];
    [line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_collectionView];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [line autoSetDimension:ALDimensionHeight toSize:1];
    
    _cancelBtn = [[QMUIButton alloc] initForAutoLayout];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    _cancelBtn.titleLabel.font = UIFont.qd_titleMediumFont;
    [_cancelBtn setTitleColor:UIColor.qd_descriptionTextColor forState:UIControlStateNormal];
    _cancelBtn.backgroundColor = UIColorMakeWithHex(@"#F4F4F4");
    [_cancelBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_cancelBtn];
    [_cancelBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line withOffset:Spaceing(5)];
    [_cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(5)];
    [_cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:Spaceing(5)];
    [_cancelBtn autoSetDimension:ALDimensionHeight toSize:SS(40)];
    
    _submitBtn = [[QMUIButton alloc] initForAutoLayout];
    [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    _submitBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
    _submitBtn.titleLabel.font = UIFont.qd_titleMediumFont;
    _submitBtn.backgroundColor = UIColor.qd_tintColor;
    [_submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_submitBtn];
    [_submitBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cancelBtn withOffset:Spaceing(4)];
    [_submitBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4)];
    [_submitBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_cancelBtn];
    [_submitBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_cancelBtn];
    [_submitBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_cancelBtn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelf)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view == self) {
        return YES;
    }
    return NO;
}

- (void)tapAction:(QMUIButton *)sender {
    if (sender == _submitBtn) {
        if (self.filterBlock) {
            if (self.beforeSubmitBlock) {
                self.beforeSubmitBlock();
            }
            self.filterBlock();
        }
    }
    [self hideSelf];
}

- (void)show {
    if (self.showBlock) {
        self.showBlock();
    }
    self.alpha = 0;
    self.hidden = NO;
    self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentViewHeight);
    [self.superview bringSubviewToFront:self];
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.alpha = 1;
        weakSelf.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [weakSelf.collectionView reloadData];
    }];
}

- (void)hideSelf {
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.alpha = 0;
        weakSelf.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentViewHeight);
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
        if (weakSelf.hideBlock) {
            weakSelf.hideBlock();
        }
        for (QDFilterRow *row in weakSelf.filterRows) {
            row.selectedIndex = row.historySelectedIndex;
        }
    }];
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _filterRows.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray<IDNameModel *> *items = _filterRows[section].items;
    return items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_filterRows[indexPath.section].itemWidth, ItemCellHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QDFilterItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QDFilterItemCell" forIndexPath:indexPath];
    NSArray<IDNameModel *> *items = _filterRows[indexPath.section].items;
    IDNameModel *item = items[indexPath.item];
    [cell updateWithTitle:item.name isSelected:indexPath.item == _filterRows[indexPath.section].selectedIndex];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _filterRows[indexPath.section].selectedIndex = indexPath.item;
    if (self.changeBlock) {
        self.changeBlock(_filterRows[indexPath.section]);
    }
    [collectionView reloadData];
}

// 设置Header的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, SpaceTitle * 2 + TitleHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *supplementaryView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *view = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterTitle" forIndexPath:indexPath];
        //这部分一定要这样写 ，否则会重影，不然就自定义headview
        UILabel *line = (UILabel *)[view viewWithTag:100];
        if (!line) {
            line = [[UILabel alloc] initForAutoLayout];
            line.tag = 100;
            line.font = UIFont.qd_titleMediumFont;
            line.textColor = UIColor.qd_titleTextColor;
            [view addSubview:line];
            [line autoSetDimension:ALDimensionHeight toSize:TitleHeight];
            [line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4)];
            [line autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SpaceTitle];
        }
        line.text = _filterRows[indexPath.section].title;
        supplementaryView = view;
    }
    return supplementaryView;
}


@end
