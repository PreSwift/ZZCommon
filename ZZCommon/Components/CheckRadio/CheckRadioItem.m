//
//  CheckRadioItem.m

//  Created by mac on 2022/2/8.
//

#import "CheckRadioItem.h"
#import "ZZCommonMacros.h"

@implementation CheckRadioItem

- (instancetype)initWithModel:(CheckRadioModel *)model {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.model = model;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    _markImageView = [[UIImageView alloc] initForAutoLayout];
    [self addSubview:_markImageView];
    [_markImageView autoSetDimensionsToSize:CGSizeMake(SS(14), SS(14))];
    [_markImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_markImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_markImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    _contentLabel = [[UILabel alloc] initForAutoLayout];
    _contentLabel.textColor = UIColor.qd_titleTextColor;
    _contentLabel.font = CodeFontMake(SS(14));
    _contentLabel.text = _model.name;
    [self addSubview:_contentLabel];
    [_contentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_markImageView withOffset:SS(5)];
    [_contentLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_markImageView];
    
    if (_model.showInputView) {
        _contentTextField = [[QMUITextField alloc] initForAutoLayout];
        _contentTextField.textColor = UIColor.qd_mainTextColor;
        _contentTextField.font = CodeFontMake(SS(14));
        _contentTextField.borderStyle = UITextBorderStyleNone;
        _contentTextField.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _contentTextField.qmui_borderColor = UIColor.qd_descriptionTextColor;
        _contentTextField.qmui_borderWidth = 1;
        _contentTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_contentTextField addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_contentTextField];
        [_contentTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_contentLabel withOffset:SS(5)];
        [_contentTextField autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_contentLabel];
        
        _descLabel = [[UILabel alloc] initForAutoLayout];
        _descLabel.textColor = UIColor.qd_descriptionTextColor;
        _descLabel.font = CodeFontMake(SS(12));
        _descLabel.text = _model.showDesc;
        [self addSubview:_descLabel];
        [NSLayoutConstraint autoSetPriority:800 forConstraints:^{
            [_descLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        }];
        [_descLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_contentTextField];
        [_descLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_contentTextField];
    } else {
        [NSLayoutConstraint autoSetPriority:800 forConstraints:^{
            [_contentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        }];
    }
    
    [self setSelected:NO];
}

- (void)editChanged:(UITextField *)textField {
    if (self.inputBlock) {
        self.inputBlock(self, textField.text);
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [_markImageView setImage:self.model.markImage];
    } else {
        [_markImageView setImage:self.model.unMarkImage];
    }
}

- (void)clearInput {
    _contentTextField.text = nil;
}

@end
