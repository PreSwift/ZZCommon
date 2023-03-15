//
//  NSBundle+Extension.m

//  Created by westMac on 2021/10/21.
//

#import "NSBundle+Extension.h"

@implementation NSBundle (Extension)

/// 应用版本
- (NSString *)appVersion {
    return self.infoDictionary[@"CFBundleShortVersionString"];
}

/// build版本
- (NSString *)buildNumber {
    return self.infoDictionary[@"CFBundleVersion"];
}

- (NSString *)currentVersonString {
    NSString *app_version = self.appVersion;
    NSArray<NSString *> *array = [app_version componentsSeparatedByString:@"."];
    if (array.count > 2) {
        if (array[2].length == 1) {
            app_version = [NSString stringWithFormat:@"%@%@0%@", array[0], array[1], array[2]];
        } else {
            app_version = [NSString stringWithFormat:@"%@%@%@", array[0], array[1], array[2]];
        }
    } else {
        app_version = [app_version stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    return app_version;
}


@end
