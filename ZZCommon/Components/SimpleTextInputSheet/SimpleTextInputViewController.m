//
//  SimpleTextInputViewController.m

//  Created by westMac on 2021/8/30.
//

#import "SimpleTextInputViewController.h"
#import "ZZCommonMacros.h"

@interface SimpleTextInputViewController () <QMUITextFieldDelegate>

@property (nonatomic, strong) QMUITextField *textField;

@end

@implementation SimpleTextInputViewController

- (void)dealloc
{
    NSLog(@"%@", self);
}

- (instancetype)initAlert
{
    self = [super init];
    if (self) {
        self.animationStyle = QMUIModalPresentationAnimationStyleSlide;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.contentViewMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(SCREEN_WIDTH, SS(50)))];
    backView.backgroundColor = UIColorWhite;
    
    QMUITextField *textField = [[QMUITextField alloc] initForAutoLayout];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    textField.placeholder = @"说点什么";
    textField.textColor = [UIColor qd_titleTextColor];
    textField.returnKeyType = UIReturnKeySend;
    textField.delegate = self;
    textField.font = CodeFontMake(SS(14));
    textField.inputAccessoryView = nil;
    [backView addSubview:textField];
    self.textField = textField;
    [textField autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [textField autoPinEdgeToSuperviewSafeArea:ALEdgeLeft withInset:SS(10)];
    
    QMUIButton *sendBtn = [[QMUIButton alloc] initForAutoLayout];
    sendBtn.backgroundColor = UIColor.qd_tintColor;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    sendBtn.titleLabel.font = CodeFontMake(SS(15));
    sendBtn.cornerRadius = SS(15);
    [sendBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [sendBtn addTarget:self action:@selector(sendBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:sendBtn];
    [sendBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:textField withOffset:SS(15)];
    [sendBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [sendBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(16)];
    [sendBtn autoSetDimensionsToSize:CGSizeMake(SS(60), SS(30))];
    
    [self setContentView:backView];
    self.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
        backView.qmui_frameApplyTransform = CGRectSetXY(backView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(backView.frame)), CGRectGetHeight(containerBounds) - CGRectGetHeight(backView.frame));
    };
    [textField becomeFirstResponder];
}

- (void)sendBtnTap {
    if (self.callBack && self.textField.hasText) {
        self.callBack(self.textField.text);
    }
    [self hideWithAnimated:YES completion:nil];
}

#pragma mark - QMUITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.hasText) {
        [self sendBtnTap];
    }
    return YES;
}

@end
