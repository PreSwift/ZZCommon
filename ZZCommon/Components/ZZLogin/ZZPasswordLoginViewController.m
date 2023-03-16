//
//  ZZPasswordLoginViewController.m

//  Created by mac on 2022/8/24.
//

#import "ZZPasswordLoginViewController.h"

@interface ZZPasswordLoginViewController ()

@property(nonatomic, strong) QMUITextField *usernameField;
@property(nonatomic, strong) QMUITextField *passwordField;
@property(nonatomic, strong) UIButton *forgetBtn;

@end

@implementation ZZPasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _usernameField.text = _initialUserName;
    _initialUserName = nil;
}

- (void)initSubviews {
    [super initSubviews];
    
    self.titleLabel.text = @"欢迎登录智慧管理系统";
    self.descLabel.text = @"使用智慧管理系统账号密码登录";
    
//    [self.otherWayBtn setTitle:@"使用手机验证码登录" forState:UIControlStateNormal];
    
    _usernameField = [[QMUITextField alloc] initForAutoLayout];
    _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    _usernameField.textColor = UIColor.qd_titleTextColor;
    _usernameField.font = CodeFontMake(SS(14));
    _usernameField.backgroundColor = UIColor.qd_imageViewBackgroundColor;
    _usernameField.placeholder = @"请输入手机号码";
    _usernameField.delegate = self;
    _usernameField.placeholderColor = UIColor.qd_descriptionTextColor;
    [_usernameField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    _usernameField.keyboardType = UIKeyboardTypeNumberPad;
    _usernameField.textInsets = UIEdgeInsetsMake(0, Spaceing(4), 0, Spaceing(4));
    _usernameField.layer.cornerRadius = SS(20);
    _usernameField.layer.masksToBounds = YES;
    _usernameField.returnKeyType = UIReturnKeyNext;
    [self.contentView addSubview:_usernameField];
    [_usernameField autoSetDimension:ALDimensionHeight toSize:SS(40)];
    [_usernameField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(30)];
    [_usernameField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(30)];
    [_usernameField autoPinEdgeToSuperviewEdge:ALEdgeTop];
    
    _passwordField = [[QMUITextField alloc] initForAutoLayout];
    _passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_passwordField setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    _passwordField.textColor = UIColor.qd_titleTextColor;
    _passwordField.placeholderColor = UIColor.qd_descriptionTextColor;
    _passwordField.font = CodeFontMake(SS(14));
    _passwordField.delegate = self;
    [_passwordField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    _passwordField.secureTextEntry = YES;
    _passwordField.placeholder = @"请输入密码";
    _passwordField.rightViewMode = UITextFieldViewModeAlways;
    _passwordField.backgroundColor = UIColor.qd_imageViewBackgroundColor;
    _passwordField.textInsets = UIEdgeInsetsMake(0, Spaceing(4), 0, Spaceing(4));
    _passwordField.layer.cornerRadius = SS(20);
    _passwordField.layer.masksToBounds = YES;
    _passwordField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:_passwordField];
    [_passwordField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_usernameField withOffset:SS(20)];
    [_passwordField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(30)];
    [_passwordField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(30)];
    [_passwordField autoSetDimension:ALDimensionHeight toSize:SS(40)];
    [_passwordField autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    QMUIButton *eyeBtn = [[QMUIButton alloc] init];
    eyeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, Spaceing(4), 0, Spaceing(4));
    [eyeBtn setImage:[UIImage imageNamed:@"mine_change password_icon_switch"] forState:UIControlStateSelected];
    [eyeBtn setImage:[UIImage imageNamed:@"mine_change password_icon_default"] forState:UIControlStateNormal];
    eyeBtn.selected = YES;
    __weak __typeof(self)weakSelf = self;
    eyeBtn.qmui_tapBlock = ^(__kindof UIControl *sender) {
        weakSelf.passwordField.secureTextEntry = !weakSelf.passwordField.isSecureTextEntry;
        sender.selected = weakSelf.passwordField.isSecureTextEntry;
    };
    _passwordField.rightView = eyeBtn;
    
//    _forgetBtn = [[UIButton alloc] initForAutoLayout];
//    _forgetBtn.hidden = YES;
//    [_forgetBtn addTarget:self action:@selector(resetpassword) forControlEvents:UIControlEventTouchUpInside];
//    [_forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    _forgetBtn.titleLabel.font = CodeFontMake(SS(14));
//    [_forgetBtn setTitleColor:UIColor.qd_tintColor forState:UIControlStateNormal];
//    _forgetBtn.contentEdgeInsets = UIEdgeInsetsZero;
//    [self.view addSubview:_forgetBtn];
//    [_forgetBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(30)];
//    [_forgetBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_passwordField withOffset:SS(5)];
}

- (void)resetpassword {
    
}

- (void)login {
    NSString *username = _usernameField.text;
    NSString *passwrod = _passwordField.text;
    if (username.length == 0) {
        [QDUITips showWithText:@"请输入手机号" inView:self.view];
        [_usernameField becomeFirstResponder];
        return;
    }
    if (passwrod.length == 0) {
        [QDUITips showWithText:@"请输入密码" inView:self.view];
        [_passwordField becomeFirstResponder];
        return;
    }
//    if (!self.checkView.isCheck) {
//        [self.checkView showActionSheet];
//        return;
//    }
    static BOOL tag = false;
    if (tag == false) {
        tag = true;
        __weak __typeof(self)weakSelf = self;
        [self showLoginLoading];
        [ComUserHelper login:username password:passwrod success:^(UserInfo * _Nullable userInfo) {
            tag = false;
            if (weakSelf) {
                weakSelf.loginSuccess();
                [weakSelf hideLoginLoading];
            }
        } failure:^(ResponseModel * _Nullable responseModel) {
            tag = false;
            [weakSelf hideLoginLoading];
            [QDUITips showError:responseModel.msg inView:weakSelf.view];
        }];
    }
}

- (void)editingChanged:(QMUITextField *)textField {
    if (_usernameField.text.length > 0 && _passwordField.text.length > 0) {
        self.sureBtn.enabled = YES;
    } else {
        self.sureBtn.enabled = NO;
    }
}

@end
