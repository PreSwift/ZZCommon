//
//  ZZWebViewController.h

//  Created by westMac on 2021/8/4.
//

#import "ZZCommonViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZWebViewController : ZZCommonViewController<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

/**
 请求连接
 */
@property (nonatomic, copy) NSString *url;

/**
 webView
 */
@property(nonatomic, strong, readonly) WKWebView *webView;

/**
 是否隐藏进度条，默认NO（展示）
 */
@property(nonatomic, assign) BOOL shouldHideProgressView;

/**
 是否隐藏导航栏，默认NO（不隐藏）
 */
@property (nonatomic, assign) BOOL shouldHideNavigationBar;

/**
 清除缓存
 */
- (void)clearCache:(void(^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
