//
//  InputSearchSheet.m
//  SmartManage
//
//  Created by mac on 2023/3/29.
//

#import "InputSearchSheet.h"
#import "ZZCommonMacros.h"

@interface InputSearchSheet() <QMUITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *showTitle;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *filterItems;
@property (nonatomic, strong) id selectItem;

@end

@implementation InputSearchSheet

- (void)dealloc
{
    NSLog(@"%@", self);
}

- (instancetype)initAlertWithItems:(NSArray *)items selectItem:(id)selectItem title:(NSString *)title
{
    self = [super init];
    if (self) {
        _showTitle = title;
        _items = items;
        _filterItems = items;
        _selectItem = selectItem ? selectItem : items.firstObject;
        self.animationStyle = QMUIModalPresentationAnimationStyleSlide;
        [self initSubviews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSInteger selectIndex = [self.filterItems indexOfObject:self.selectItem];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    });
}

- (void)initSubviews {
    self.contentViewMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(SCREEN_WIDTH, SS(600)))];
    backView.backgroundColor = UIColorWhite;
    
    QMUIButton *cancelBtn = [[QMUIButton alloc] initForAutoLayout];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = CodeFontMake(SS(17));
    [cancelBtn addTarget:self action:@selector(cancelBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:cancelBtn];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4)];
    [cancelBtn autoSetDimension:ALDimensionHeight toSize:SS(50)];
    
    UILabel *titleLabel = [[UILabel alloc] initForAutoLayout];
    titleLabel.font = CodeFontMake(SS(17));
    titleLabel.text = self.showTitle;
    titleLabel.textColor = UIColor.qd_titleTextColor;
    [backView addSubview:titleLabel];
    [titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:cancelBtn];
    [titleLabel autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
    
    QMUIButton *sendBtn = [[QMUIButton alloc] initForAutoLayout];
    [sendBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sendBtn setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
    sendBtn.titleLabel.font = CodeFontMake(SS(17));
    [sendBtn addTarget:self action:@selector(sendBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:sendBtn];
    [sendBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [sendBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4)];
    [sendBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:cancelBtn];
    
    UIView *line = [[UIView alloc] initForAutoLayout];
    line.backgroundColor = UIColor.qd_separatorColor;
    [backView addSubview:line];
    [line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:cancelBtn];
    [line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [line autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [line autoSetDimension:ALDimensionHeight toSize:PixelOne];
    
    QMUITextField *textField = [[QMUITextField alloc] initForAutoLayout];
    textField.layer.borderColor = UIColor.qd_tintColor.CGColor;
    textField.layer.borderWidth = PixelOne;
    textField.layer.cornerRadius = SS(22);
    textField.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1];
    textField.placeholder = @"输入快速搜索";
    textField.textColor = [UIColor qd_titleTextColor];
    textField.font = CodeFontMake(SS(14));
    textField.returnKeyType = UIReturnKeyDone;
    [textField addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
    textField.delegate = self;
    textField.inputAccessoryView = nil;
    textField.textInsets = UIEdgeInsetsMake(0, Spaceing(3), 0, Spaceing(3));
    [backView addSubview:textField];
    self.textField = textField;
    [textField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:line withOffset:Spaceing(3)];
    [textField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:Spaceing(4)];
    [textField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:Spaceing(4)];
    [textField autoSetDimension:ALDimensionHeight toSize:SS(44)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorInset = UIEdgeInsetsZero;
    [backView addSubview:_tableView];
    [_tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:textField withOffset:Spaceing(3)];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SafeAreaInsetsConstantForDeviceWithNotch.bottom];
    
    [self setContentView:backView];
    self.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        backView.qmui_frameApplyTransform = CGRectSetXY(backView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(backView.frame)), CGRectGetHeight(containerBounds) - CGRectGetHeight(backView.frame));
    };
    
    
}

- (void)cancelBtnTap {
    [self hideWithAnimated:YES completion:nil];
}

- (void)sendBtnTap {
    if (self.didSelectItemBlock) {
        if (self.selectItem) {
            self.didSelectItemBlock(self.selectItem);
            [self hideWithAnimated:YES completion:nil];
        } else {
            [ZZUITips showWithText:[NSString stringWithFormat:@"请选择%@", self.showTitle] inView:self.view];
        }
    }
}

- (void)editChanged:(QMUITextField *)textField {
    NSString *searchText = textField.text;
    if (searchText.length > 0) {
        __weak __typeof(self)weakSelf = self;
        self.filterItems = [self.items qmui_filterWithBlock:^BOOL(id  _Nonnull item) {
            return [weakSelf.itemNameBlock(item) containsString:searchText];
        }];
    } else {
        self.filterItems = self.items;
    }
    if (self.filterItems.count == 0) {
        [self.contentView showEmptyViewWithText:@"无匹配结果"];
    } else {
        [self.contentView hideEmptyView];
    }
    if (![self.filterItems containsObject:self.selectItem]) {
        self.selectItem = nil;
    }
    [self.tableView reloadData];
}

#pragma mark - QMUITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filterItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = UIColor.qd_titleTextColor;
        cell.textLabel.font = CodeFontMake(SS(17));
        cell.qmui_selectedBackgroundColor = UIColor.qd_separatorColor;
    }
    cell.textLabel.text = self.itemNameBlock(self.filterItems[indexPath.row]);
    cell.selected = self.selectItem == self.filterItems[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectItem = self.filterItems[indexPath.row];
}

@end
