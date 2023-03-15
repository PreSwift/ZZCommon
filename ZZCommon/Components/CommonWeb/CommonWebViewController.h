//
//  CommonWebViewController.h

//  Created by westMac on 2021/8/4.
//

#import "ZZCommonViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonWebViewController : ZZCommonViewController


- (instancetype)initWithUrl: (NSString *)url;

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, assign) BOOL hideProgressView;
@property(nonatomic, assign) BOOL showShareBar;
@property(nonatomic, strong) NSString *shareUrl;
@property(nonatomic, copy) void(^sizeDidChangeBlock)(CGSize size);

/**
 清除缓存
 */
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
