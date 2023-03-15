//
//  NumberInputView.m
//  teacher
//
//  Created by westMac on 2021/12/7.
//

#import "NumberInputView.h"

@interface NumberInputView ()

@property(nonatomic, strong) QMUIButton *reduceBtn;
@property(nonatomic, strong) QMUIButton *addBtn;
@property(nonatomic, strong) QMUITextField *textFild;

@end

@implementation NumberInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.layer.cornerRadius = SS(4);
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = PixelOne;
    self.layer.borderColor = [UIColor qd_descriptionTextColor].CGColor;
    
    _reduceBtn = [[QMUIButton alloc] initForAutoLayout];
    _reduceBtn.titleLabel.font = CodeBoldFontMake(SS(14));
    [_reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [_reduceBtn setTitleColor:UIColor.qd_descriptionTextColor forState:UIControlStateNormal];
    [_reduceBtn addTarget:self action:@selector(tapReduceBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceBtn];
    [_reduceBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [_reduceBtn autoSetDimension:ALDimensionWidth toSize:SS(28) relation:NSLayoutRelationGreaterThanOrEqual];
    [_reduceBtn autoSetDimension:ALDimensionHeight toSize:SS(28) relation:NSLayoutRelationGreaterThanOrEqual];
    
    _textFild = [[QMUITextField alloc] initForAutoLayout];
    _textFild.font = CodeFontMake(SS(14));
    _textFild.textColor = UIColor.qd_tintColor;
    _textFild.textAlignment = NSTextAlignmentCenter;
    _textFild.text = @"1分";
    _textFild.keyboardType = UIKeyboardTypePhonePad;
    _textFild.maximumTextLength = 4;
    _textFild.qmui_borderPosition = QMUIViewBorderPositionLeft | QMUIViewBorderPositionRight;
    _textFild.qmui_borderColor = [UIColor qd_descriptionTextColor];
    [_textFild addTarget:self action:@selector(editDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    [self addSubview:_textFild];
    [_textFild autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_textFild autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_textFild autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_reduceBtn];
    [_textFild autoSetDimension:ALDimensionWidth toSize:SS(50) relation:NSLayoutRelationGreaterThanOrEqual];
    
    _addBtn = [[QMUIButton alloc] initForAutoLayout];
    _addBtn.titleLabel.font = CodeBoldFontMake(SS(14));
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addBtn setTitleColor:UIColor.qd_descriptionTextColor forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(tapAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    [_addBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [_addBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_textFild];
    [_addBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_reduceBtn];
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        _textFild.text = text;
    }
}

- (void)tapReduceBtn {
    NSInteger value = [_textFild.text integerValue];
    if (value > 1) {
        _textFild.text = [NSString stringWithFormat:@"%ld分", value - 1];
        [self editDidEnd];
    }
}

- (void)tapAddBtn {
    NSInteger value = [_textFild.text integerValue];
    if (value < 999) {
        _textFild.text = [NSString stringWithFormat:@"%ld分", value + 1];
        [self editDidEnd];
    }
}

- (void)editDidEnd {
    if (self.editChangedBlock) {
        self.editChangedBlock(_textFild.text);
    }
}

@end
