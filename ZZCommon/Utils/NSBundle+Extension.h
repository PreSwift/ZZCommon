//
//  NSBundle+Extension.h
//  jzjx
//
//  Created by westMac on 2021/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Extension)

@property(nonatomic, strong, readonly) NSString *appVersion;
@property(nonatomic, strong, readonly) NSString *buildNumber;
@property(nonatomic, strong, readonly) NSString *currentVersonString;

@end

NS_ASSUME_NONNULL_END
