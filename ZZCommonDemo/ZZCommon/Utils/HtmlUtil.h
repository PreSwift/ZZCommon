//
//  HtmlUtil.h
//  jzjx
//
//  Created by westMac on 2021/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HtmlUtil : NSObject

@property(nonatomic, strong) NSString *htmlString;
@property(nonatomic, strong) NSURL *baseURL;

+ (void)getLocalHTMLFileWithDiVContent:(NSString *)content success:(void(^)(NSString *htmlStr, NSURL *baseURL))successBlock;

@end

NS_ASSUME_NONNULL_END
