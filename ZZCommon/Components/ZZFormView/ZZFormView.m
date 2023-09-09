//
//  ZZFormView.m
//  jzjx
//
//  Created by Ethan on 2022/9/28.
//

#import "ZZFormView.h"
#import "ZZFormRowTableViewCell.h"

@interface ZZFormView() <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UITableView *mainTableView;
@property(nonatomic, strong) UITableView *floatLeftTableView;
@property(nonatomic, strong) UITableView *floatTopTableView;
@property(nonatomic, strong) UITableView *leftTopTableView;
@property(nonatomic, strong) NSLayoutConstraint *mainTableViewWidthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *mainTableViewHeightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *floatTopTableViewHeightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *floatLeftTableViewWidthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *leftTopTableViewWidthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *leftTopTableViewHidthConstraint;

@property(nonatomic, strong) UIView *vSepLine1;
@property(nonatomic, strong) UIView *vSepLine2;
@property(nonatomic, strong) UIView *hSepLine1;
@property(nonatomic, strong) UIView *hSepLine2;

@property(nonatomic, assign) BOOL isBottom;

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
    _floatTopTableView.userInteractionEnabled = NO;
    _floatTopTableView.hidden = YES;
    [_scrollView addSubview:_floatTopTableView];
    [_floatTopTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_floatTopTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    [_floatTopTableView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_mainTableView];
    _floatTopTableViewHeightConstraint = [_floatTopTableView autoSetDimension:ALDimensionHeight toSize:0];
    
    _floatLeftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _floatLeftTableView.tableFooterView = UIView.new;
    _floatLeftTableView.separatorInset = UIEdgeInsetsZero;
    _floatLeftTableView.separatorColor = UIColor.qd_separatorColor;
    _floatLeftTableView.dataSource = self;
    _floatLeftTableView.delegate = self;
    _floatLeftTableView.bounces = NO;
    _floatLeftTableView.userInteractionEnabled = NO;
    _floatLeftTableView.hidden = YES;
    [_scrollView addSubview:_floatLeftTableView];
    [_floatLeftTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [_floatLeftTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_mainTableView];
    [_floatLeftTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_mainTableView];
    _floatLeftTableViewWidthConstraint = [_floatLeftTableView autoSetDimension:ALDimensionWidth toSize:0];
    
    _leftTopTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _leftTopTableView.tableFooterView = UIView.new;
    _leftTopTableView.separatorInset = UIEdgeInsetsZero;
    _leftTopTableView.separatorColor = UIColor.qd_separatorColor;
    _leftTopTableView.dataSource = self;
    _leftTopTableView.delegate = self;
    _leftTopTableView.bounces = NO;
    _leftTopTableView.userInteractionEnabled = NO;
    _leftTopTableView.hidden = YES;
    _leftTopTableView.layer.borderWidth = PixelOne;
    _leftTopTableView.layer.borderColor = UIColor.qd_separatorColor.CGColor;
    _leftTopTableView.backgroundColor = UIColor.redColor;
    [_scrollView addSubview:_leftTopTableView];
    [_leftTopTableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [_leftTopTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    _leftTopTableViewWidthConstraint = [_leftTopTableView autoSetDimension:ALDimensionWidth toSize:0];
    _leftTopTableViewHidthConstraint = [_leftTopTableView autoSetDimension:ALDimensionHeight toSize:0];
    
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
}

- (void)updateWithRows:(NSArray<ZZFormRowModel *> *)rows {
    _rows = rows;
    
    __block CGFloat floatLeftWidth = 0, floatTopHeight = 0, tableWidth = 0, tableHeight = 0;
    [_rows.firstObject.items enumerateObjectsUsingBlock:^(ZZFormItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        tableWidth += obj.itemWidth;
        if (idx < self.floatLeftColumnNumber) {
            floatLeftWidth += obj.itemWidth;
        }
    }];
    [rows enumerateObjectsUsingBlock:^(ZZFormRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        tableHeight += obj.rowHeight;
        if (idx < self.floatTopRowNumber) {
            floatTopHeight += obj.rowHeight;
        }
    }];
    // 如果支持左浮动
    if (_floatLeftColumnNumber > 0) {
        _floatLeftTableViewWidthConstraint.constant = floatLeftWidth;
        [self.floatLeftTableView reloadData];
    }
    // 如果支持上浮动
    if (_floatTopRowNumber > 0) {
        _floatTopTableViewHeightConstraint.constant = floatTopHeight;
        [self.floatTopTableView reloadData];
    }
    // 如果同时支持
    if (_floatLeftColumnNumber > 0 && _floatTopRowNumber > 0) {
        _leftTopTableViewWidthConstraint.constant = floatLeftWidth;
        _leftTopTableViewHidthConstraint.constant = floatTopHeight;
        [self.leftTopTableView reloadData];
    }
    // 刷新主图
    _mainTableViewWidthConstraint.constant = tableWidth;
    _mainTableViewHeightConstraint.constant = tableHeight;
    [self.mainTableView reloadData];
    
    _vSepLine1.hidden = rows.count == 0;
    _vSepLine2.hidden = rows.count == 0;
    _hSepLine1.hidden = rows.count == 0;
    _hSepLine2.hidden = rows.count == 0;
}

- (void)scrollToRow:(ZZFormRowModel *)row animated:(BOOL)animated {
    NSInteger index = [self.rows indexOfObject:row];
    if (index != NSNotFound) {
        [self.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:animated];
        [self.floatLeftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:animated];
    }
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _floatTopTableView || tableView == _leftTopTableView) {
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
        __weak __typeof(self)weakSelf = self;
        cell.tapCellBlock = ^(ZZFormRowModel * _Nonnull rowModel, NSInteger column, QMUIButton *sender) {
            NSInteger row = [weakSelf.rows indexOfObject:rowModel];
            if (weakSelf.tapCellBlock) {
                weakSelf.tapCellBlock(row, column, sender);
            }
        };
    }
    ZZFormRowModel *row = _rows[indexPath.row];
    cell.selectedMaskView.backgroundColor = row.selectedBackgroundColor;
    cell.selectedMaskView.hidden = YES;
    if (tableView == _floatLeftTableView || tableView == _leftTopTableView) {
        [cell updateWithRowModel:row toItemIndex:_floatLeftColumnNumber];
    } else {
        [cell updateWithRowModel:row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZFormRowModel *row = _rows[indexPath.row];
    if (row.selectionStyle != UITableViewCellSelectionStyleNone) {
        ZZFormRowTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectedMaskView.alpha = 1;
        cell.selectedMaskView.hidden = NO;
    }
    if (tableView == self.mainTableView && row.selectionStyle != UITableViewCellSelectionStyleNone) {
        [self tableView:self.floatLeftTableView didHighlightRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZFormRowModel *row = _rows[indexPath.row];
    if (row.selectionStyle != UITableViewCellSelectionStyleNone) {
        ZZFormRowTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [UIView qmui_animateWithAnimated:YES duration:0.2 animations:^{
            cell.selectedMaskView.alpha = 0;
        } completion:^(BOOL finished) {
            cell.selectedMaskView.hidden = YES;
        }];
    }
    if (tableView == self.mainTableView && row.selectionStyle != UITableViewCellSelectionStyleNone) {
        [self tableView:self.floatLeftTableView didUnhighlightRowAtIndexPath:indexPath];
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
        
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        if(y == h && _isBottom == NO) {
            _isBottom = true;
            if(self.scrollViewDidScrollToBottomBlock)
                self.scrollViewDidScrollToBottomBlock(scrollView);
        } else {
            _isBottom = false;
        }
    }
    if (scrollView == _scrollView || scrollView == _mainTableView) {
        if (_floatTopRowNumber > 0 && _floatLeftColumnNumber > 0) {
            if (_scrollView.contentOffset.x == 0 && _mainTableView.contentOffset.y == 0) {
                _leftTopTableView.hidden = YES;
            } else {
                _leftTopTableView.hidden = NO;
            }
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.scrollViewWillEndDraggingBlock) {
        self.scrollViewWillEndDraggingBlock(scrollView, velocity);
    }
}

@end
