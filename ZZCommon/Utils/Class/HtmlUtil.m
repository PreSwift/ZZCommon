//
//  HtmlUtil.m

//  Created by westMac on 2021/12/22.
//

#import "HtmlUtil.h"

@implementation HtmlUtil

+ (HtmlUtil *)shareInstance {
    static dispatch_once_t onceToken;
    static HtmlUtil *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (void)getLocalHTMLFileWithDiVContent:(NSString *)content success:(void (^)(NSString * _Nonnull, NSURL * _Nonnull))successBlock {
    if (content == nil) {
        return;
    }
    NSURL *baseURL = [HtmlUtil shareInstance].baseURL;
    NSString *htmlStr = [HtmlUtil shareInstance].htmlString;
    if ([HtmlUtil shareInstance].baseURL == nil) {
        NSString *mainBundlePath = [[NSBundle mainBundle] bundlePath];
        NSString *basePath = [NSString stringWithFormat:@"%@/HTMLTemplate", mainBundlePath];
        baseURL = [NSURL fileURLWithPath:basePath isDirectory:YES];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HTMLTemplate/index" ofType:@"html"];
        htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    }
    NSMutableString  *a = [[NSMutableString alloc] initWithString:htmlStr];
    NSRange bodyRange = [a rangeOfString:@"<div id='quWebView'>"];
    [a insertString:content atIndex:bodyRange.location + bodyRange.length];
    if (successBlock) {
        successBlock(a, baseURL);
    }
}

@end
