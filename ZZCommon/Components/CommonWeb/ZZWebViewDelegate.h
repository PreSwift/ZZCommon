//
//  ZZWebViewDelegate.h

//  Created by westMac on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZWebViewDelegate : NSObject<WKScriptMessageHandler>

- (instancetype)initWithScriptDelegate: (id<WKScriptMessageHandler>)delegate;

@end

NS_ASSUME_NONNULL_END
