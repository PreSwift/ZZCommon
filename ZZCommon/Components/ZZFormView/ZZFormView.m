//
//  ZZFormView.m

//  Created by Ethan on 2022/9/28.
//

#import "ZZFormView.h"
#import "ZZCommonMacros.h"

@interface ZZFormView() <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) QMUIButton *leftTopLabel;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UITableView *mainTableView;
@property(nonatomic, strong) UITableView *floatLeftTableView;
@property(nonatomic, strong) UITableView *floatTopTableView;
@property(nonatomic, strong) NSLayoutConstraint *mainTableViewWidthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *mainTableViewHeightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *floatTopTableViewHeightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *floatLeftTableViewWidthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *leftTopLabelWidthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *leftTopLabelHidthConstraint;

@property(nonatomic, strong) UIView *vSepLine1;
@property(nonatomic, strong) UIView *vSepLine2;
@property(nonatomic, strong) UIView *hSepLine1;
@property(nonatomic, strong) UIView *hSepLine2;

@end

@implementation ZZFormView

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
    
    _scrollView = [[UIScrollView alloc] initForAutoLayout];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    [_scrollView autoPinEdgesToSuperviewEdges];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mainTableView.tableFooterView = UIView.new;
    _mainTableView.separatorInset = UIEdgeInsetsZero;
    _mainTableView.separatorColor = UIColor.qd_separatorColor;
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    _mainTableView.bounces = NO;
    [_scrollView addSubview:_mainTableView];
    [_mainTableView autoPinEdgesToSuperviewEdges];
    [_mainTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    [_mainTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:0 relation:NSLayoutRelationLessThanOrEqual];
    _mainTableViewWidthConstraint = [_mainTableView autoSetDimension:ALDimensionWidth toSize:0];
    [NSLayoutConstraint autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        _mainTableViewHeightConstraint = [_mainTableView autoSetDimension:ALDimensionHeight toSize:0];
    }];
    
    _floatTopTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _floatTopTableView.tableFooterView = UIView.new;
    _floatTopTableView.separatorInset = UIEdgeInsetsZero;
    _floatTopTableView.separatorColor = UIColor.qd_separatorColor;
    _floatTopTableView.dataSource = self;
    _floatTopTableView.delegate = self;
    _floatTopTableView.hidden = YES;
    [_scrollView addSubview:_floatTopTableView];
    [_floatTopTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_floatTopTableView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_mainTableView];
    [_floatTopTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    _floatTopTableViewHeightConstraint = [_floatTopTableView autoSetDimension:ALDimensionHeight toSize:0];
    
    _floatLeftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _floatLeftTableView.tableFooterView = UIView.new;
    _floatLeftTableView.separatorInset = UIEdgeInsetsZero;
    _floatLeftTableView.separatorColor = UIColor.qd_separatorColor;
    _floatLeftTableView.dataSource = self;
    _floatLeftTableView.delegate = self;
    _floatTopTableView.bounces = NO;
    _floatLeftTableView.userInteractionEnabled = NO;
    _floatLeftTableView.hidden = YES;
    [_scrollView addSubview:_floatLeftTableView];
    [_floatLeftTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [_floatLeftTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_mainTableView];
    [_floatLeftTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_mainTableView];
    _floatLeftTableViewWidthConstraint = [_floatLeftTableView autoSetDimension:ALDimensionWidth toSize:0];
    
    _leftTopLabel = [[QMUIButton alloc] initForAutoLayout];
    _leftTopLabel.hidden = YES;
    _leftTopLabel.layer.borderWidth = PixelOne;
    _leftTopLabel.layer.borderColor = UIColor.qd_separatorColor.CGColor;
    [_scrollView addSubview:_leftTopLabel];
    [_leftTopLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [_leftTopLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    _leftTopLabelWidthConstraint = [_leftTopLabel autoSetDimension:ALDimensionWidth toSize:0];
    _leftTopLabelHidthConstraint = [_leftTopLabel autoSetDimension:ALDimensionHeight toSize:0];
    
    _vSepLine1 = [[UIView alloc] initForAutoLayout];
    _vSepLine1.backgroundColor = UIColor.qd_separatorColor;
    _vSepLine1.hidden = YES;
    [self addSubview:_vSepLine1];
    [_vSepLine1 autoSetDimension:ALDimensionWidth toSize:PixelOne];
    [_vSepLine1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_vSepLine1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_mainTableView];
    [_vSepLine1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_mainTableView];
    
    _vSepLine2 = [[UIView alloc] initForAutoLayout];
    _vSepLine2.backgroundColor = UIColor.qd_separatorColor;
    _vSepLine2.hidden = YES;
    [self addSubview:_vSepLine2];
    [_vSepLine2 autoSetDimension:ALDimensionWidth toSize:PixelOne];
    [_vSepLine2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_vSepLine2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_mainTableView];
    [_vSepLine2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_mainTableView];
    
    _hSepLine1 = [[UIView alloc] initForAutoLayout];
    _hSepLine1.backgroundColor = UIColor.qd_separatorColor;
    _hSepLine1.hidden = YES;
    [self addSubview:_hSepLine1];
    [_hSepLine1 autoSetDimension:ALDimensionHeight toSize:PixelOne];
    [_hSepLine1 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    
    _hSepLine2 = [[UIView alloc] initForAutoLayout];
    _hSepLine2.backgroundColor = UIColor.qd_separatorColor;
    _hSepLine2.hidden = YES;
    [self addSubview:_hSepLine2];
    [_hSepLine2 autoSetDimension:ALDimensionHeight toSize:PixelOne];
    [_hSepLine2 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_hSepLine2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_hSepLine2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_mainTableView];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    [_scrollView setScrollEnabled:scrollEnabled];
    [_mainTableView setScrollEnabled:scrollEnabled];
    [_floatLeftTableView setScrollEnabled:scrollEnabled];
    [_floatTopTableView setScrollEnabled:scrollEnabled];
}

- (void)updateWithRows:(NSArray<ZZFormRowModel *> *)rows {
    _rows = rows;
    
    ZZFormRowModel *firstRow = _rows.firstObject;
    // 如果支持左浮动
    if (_floatLeftColumnNumber > 0) {
        ZZFormItemModel *topLeftItem = rows.firstObject.items.firstObject;
        [_leftTopLabel setBackgroundColor:topLeftItem.backgroundColor];
        [_leftTopLabel setTitleColor:topLeftItem.textColor forState:UIControlStateNormal];
        _leftTopLabel.contentEdgeInsets = topLeftItem.contentPadding;
        _leftTopLabel.titleLabel.textAlignment = topLeftItem.textAlignment;
        _leftTopLabel.titleLabel.font = topLeftItem.textFont;
        _leftTopLabel.titleLabel.numberOfLines = topLeftItem.numberOfLines;
        [_leftTopLabel setTitle:topLeftItem.content forState:UIControlStateNormal];
        [_leftTopLabel setImagePosition:topLeftItem.accessoryImagePosition];
        _leftTopLabel.spacingBetweenImageAndTitle = topLeftItem.spacingBetweenAccessoryImageAndContent;
        [_leftTopLabel setImage:topLeftItem.accessoryImage forState:UIControlStateNormal];
                
        _floatLeftTableViewWidthConstraint.constant = topLeftItem.itemWidth;
        _leftTopLabelHidthConstraint.constant = firstRow.rowHeight;
        _leftTopLabelWidthConstraint.constant = topLeftItem.itemWidth;
        [self.floatLeftTableView reloadData];
    }
    // 如果支持上浮动
    if (_floatTopRowNumber > 0) {
        _floatTopTableViewHeightConstraint.constant = firstRow.rowHeight;
        [self.floatTopTableView reloadData];
    }
    // 刷新主图标
    __block CGFloat tableWidth = 0;
    [firstRow.items enumerateObjectsUsingBlock:^(ZZFormItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        tableWidth += obj.itemWidth;
    }];
    __block CGFloat tableHeight = 0;
    [rows enumerateObjectsUsingBlock:^(ZZFormRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        tableHeight += obj.rowHeight;
    }];
    _mainTableViewWidthConstraint.constant = tableWidth;
    _mainTableViewHeightConstraint.constant = tableHeight;
    [self.mainTableView reloadData];
    
    _vSepLine1.hidden = rows.count == 0;
    _vSepLine2.hidden = rows.count == 0;
    _hSepLine1.hidden = rows.count == 0;
    _hSepLine2.hidden = rows.count == 0;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _floatTopTableView) {
        return _rows.count > 0 ? _floatTopRowNumber : 0;
    }
    if (tableView == _floatLeftTableView) {
        return _floatLeftColumnNumber > 0 ? _rows.count : 0;
    }
    return _rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _rows[indexPath.row].rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ZZFormRowTableViewCell";
    ZZFormRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZZFormRowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ZZFormRowModel *row = _rows[indexPath.row];
    cell.selectionStyle = row.selectionStyle;
    cell.selectedBackgroundView.backgroundColor = row.selectedBackgroundColor;
    if (tableView == _floatLeftTableView) {
        [cell updateWithRowModel:row toItemIndex:_floatLeftColumnNumber];
    } else {
        [cell updateWithRowModel:row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZFormRowModel *row = _rows[indexPath.row];
    if (row.selectionStyle != UITableViewCellSelectionStyleNone) {
        [_floatLeftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZFormRowModel *row = _rows[indexPath.row];
    if (row.selectionStyle != UITableViewCellSelectionStyleNone) {
        [_floatLeftTableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.tapRowBlock) {
        self.tapRowBlock(indexPath.row);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _scrollView) {
        if (scrollView.contentOffset.x > 0 && _floatLeftTableView.isHidden == YES) {
            _floatLeftTableView.hidden = NO;
        } else if (scrollView.contentOffset.x <= 0 && _floatLeftTableView.isHidden == NO) {
            _floatLeftTableView.hidden = YES;
        }
    } else if (scrollView == _mainTableView) {
        [_floatLeftTableView setContentOffset:scrollView.contentOffset];
        if (scrollView.contentOffset.y > 0 && _floatTopTableView.isHidden == YES) {
            _floatTopTableView.hidden = NO;
        } else if (scrollView.contentOffset.y <= 0 && _floatTopTableView.isHidden == NO) {
            _floatTopTableView.hidden = YES;
        }
    }
    if (_scrollView.contentOffset.x == 0 && _mainTableView.contentOffset.y == 0) {
        _leftTopLabel.hidden = YES;
    } else {
        _leftTopLabel.hidden = NO;
    }
}

@end
