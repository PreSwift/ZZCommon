//
//  ValicodeUtil.h
//  teacher
//
//  Created by westMac on 2021/9/9.
//

#import <Foundation/Foundation.h>
#import "CountdownTimer.h"

#define ValicodeCountDownSeconds 60
// NotificationName
#define NotificationNameValicodeCountDown @"ValicodeCountDown"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ValicodeCallback) (NSInteger code, NSString * _Nullable msg);

@interface ValicodeUtil : NSObject

// 发送验证码
+ (void)sendValicode: (NSString *)phone userId:(NSString *)userId callback: (ValicodeCallback)callback;
+ (void)sendRegistValicode:(NSString *)phone userId:(NSString *)userId callback:(ValicodeCallback)callback;

@end

NS_ASSUME_NONNULL_END
