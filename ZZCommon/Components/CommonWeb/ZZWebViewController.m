//
//  ZZWebViewController.m

//  Created by westMac on 2021/8/4.
//

#import "ZZWebViewController.h"
#import "ZZWebViewDelegate.h"
#import "ZZCommonMacros.h"

@implementation ZZWebViewController

- (void)dealloc {
    [_webView stopLoading];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fixGestureGoBack];
    
    // request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
}

- (void)initSubviews {
    [super initSubviews];
    NSAssert(_url, @"请设置URL");

    _webView = [[WKWebView alloc] initForAutoLayout];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];
    [_webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (BOOL)preferredNavigationBarHidden {
    return self.shouldHideNavigationBar;
}

- (void)clearCache:(void (^)(void))completionHandler {
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        completionHandler();
    }];
}

- (void)finishLoad {
    [self.view hideEmptyView];
    if (self.webView.title.length > 0) {
        self.navigationItem.title = self.webView.title;
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (!_shouldHideProgressView) {
        [self.view showEmptyViewWithLoading];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self finishLoad];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self finishLoad];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

@end
