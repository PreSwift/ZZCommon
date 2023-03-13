//
//  CommonWebViewController.m
//  jzjx
//
//  Created by westMac on 2021/8/4.
//

#import "CommonWebViewController.h"
#import "CommonWebViewDelegate.h"
#import "CommonWebShareBarView.h"


#define SaveEmailKey @"SaveEmailKey"

@interface CommonWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic,copy) NSString *url;

@property (nonatomic,assign) BOOL navigationBarHidden;

@end

@implementation CommonWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
        NSLog(@"%@", url);
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@", self);
    [_webView stopLoading];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"commonCall"];
}

- (void)initSubviews {
    [super initSubviews];

    _webView = [[WKWebView alloc] initForAutoLayout];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.allowsBackForwardNavigationGestures = YES;
    [_webView.configuration.userContentController addScriptMessageHandler:[[CommonWebViewDelegate alloc] initWithScriptDelegate:self] name:@"commonCall"];
    [self.view addSubview:_webView];
    if (self.navigationController != nil) {
        [_webView autoPinEdgesToSuperviewSafeAreaWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    } else {
        [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    }
    
    // 先清除缓存
    [self clearCache];
    // request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    
    if (_showShareBar) {
        
    } else {
        if (self.navigationController != nil) {
            [_webView autoPinEdgeToSuperviewSafeArea:ALEdgeBottom];
        } else {
            [_webView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        }
    }
    
    [self fixGestureGoBack];
}

- (BOOL)preferredNavigationBarHidden {
    return self.navigationBarHidden;
}

- (void)clearCache {
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (!_hideProgressView) {
        [self.view showEmptyViewWithLoading];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.view hideEmptyView];
    if (webView.title.length > 0) {
        self.navigationItem.title = webView.title;
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark - WKUIDelegate

- (void)webViewDidClose:(WKWebView *)webView {
    
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    NSLog(@"%@", message.body);
    if ([message.name isEqualToString:@"commonCall"]) {
        if ([message.body isKindOfClass:NSDictionary.class]) {
            NSDictionary *jsonMessageBody = [NSDictionary dictionaryWithDictionary: message.body];
            id type = jsonMessageBody[@"type"];
            if ([type isKindOfClass:NSNumber.class]) {
                int intType = [type intValue];
                /**
                 1、返回
                 2、获取token和schoolID
                 3、隐藏系统导航栏，显示自定义导航栏
                 4、返回宽高
                 */
                
                if (intType == 1) {
                    [self popVC];
                } else if (intType == 2) {
                    [self callBackBasicInfo];
                } else if (intType == 3) {
                    self.navigationBarHidden = YES;
                    // 利用runtime调用QMUI内部方法
                    [self performSelector:@selector(renderNavigationBarStyleAnimated:)];
                } else if (intType == 4) {
                    CGFloat width = [jsonMessageBody[@"width"] floatValue];
                    CGFloat height = [jsonMessageBody[@"height"] floatValue];
//                    if (IS_IPAD) {
                        height = height * self.webView.qmui_width / width;
//                    }
                    if (self.sizeDidChangeBlock) {
                        self.sizeDidChangeBlock(CGSizeMake(width, height));
                    }
                }
            }
        }
    }
}

#pragma mark - 自定义方法

- (void)popVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)callBackBasicInfo {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"token"] = [ComUserHelper shareInstance].accessToken;
    parameter[@"userID"] = [NSNumber numberWithInteger:[ComUserHelper shareInstance].userInfo.employeeId];
    NSString *jsEvaluate = [NSString stringWithFormat:@"initView(%@)", [parameter mj_JSONString]];
    NSLog(@"jsEvaluate: %@", jsEvaluate);
    [_webView evaluateJavaScript:jsEvaluate completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        NSLog(@"Obj: %@ \n Error: %@", obj, error);
    }];
}

@end
