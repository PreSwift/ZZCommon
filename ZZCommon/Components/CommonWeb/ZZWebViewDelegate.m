//
//  ZZWebViewDelegate.m

//  Created by westMac on 2021/8/4.
//

#import "ZZWebViewDelegate.h"

@interface ZZWebViewDelegate ()

@property(nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

@end

@implementation ZZWebViewDelegate

- (void)dealloc {
}

- (instancetype)initWithScriptDelegate:(id<WKScriptMessageHandler>)delegate {
    self = [super init];
    if (self) {
        self.scriptDelegate = delegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
