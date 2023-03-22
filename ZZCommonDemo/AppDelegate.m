//
//  AppDelegate.m
//  ZZCommonDemo
//
//  Created by mac on 2023/3/15.
//

#import "AppDelegate.h"
#import <ZZCommon/ZZCommon.h>

@interface AppDelegate ()

@property(nonatomic, strong) NSString *uuidStr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 配置HOST
    [ZZApiHelper configForBaseHost:@"https://erp.wtjy.com/" baseWebHost:nil cdnHost:nil];
    __weak __typeof(self)weakSelf = self;
    [ZZApiHelper configForDefaultHeader:^NSDictionary<NSString *,NSString *> * _Nullable(NSDictionary<NSString *,NSString *> * _Nullable oldHeader) {
        return [weakSelf handleHeader:oldHeader];
    }];
    [ZZApiHelper configForStatusCodeValidator:^BOOL(YTKRequest * _Nonnull request) {
        return [weakSelf statusCodeValidator:request];
    }];
    
    return YES;
}

/**
 配置公共Header处理
 */
- (nullable NSDictionary <NSString *, NSString *> *)handleHeader:(NSDictionary <NSString *, NSString *>  * _Nullable)oldHeader {
    NSMutableDictionary *newHeader;
    if (oldHeader == NULL) {
        newHeader = [NSMutableDictionary dictionary];
    } else if (![oldHeader.allKeys containsObject:@"Authorization"]) {
        newHeader = [NSMutableDictionary dictionaryWithDictionary:oldHeader];
    }
    if (newHeader!=NULL) {
        newHeader[@"platform"] = @"2";
        if (_uuidStr == NULL) {
            _uuidStr = [[UUIDStringThen alloc] getDeviceIDInKeychain];
        }
        newHeader[@"deviceId"] = _uuidStr;
        newHeader[@"version"] = [NSBundle mainBundle].currentVersonString;
        return newHeader;
    }
   
    return oldHeader;
}

/**
 配置公共StatusCode处理
 */
- (BOOL)statusCodeValidator:(YTKRequest *)request {
    NSInteger statusCode = [request responseStatusCode];
    NSString *errorMsg = [[request responseJSONObject] valueForKey:@"msg"];
    if ((statusCode == 401 || statusCode == 424)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZZDialogHelper showAlertDialog:@"温馨提示" content:errorMsg ? errorMsg : @"用户凭证已过期，请重新登录!" okBlock:^(__kindof QMUIModalPresentationViewController * _Nonnull dialogViewController) {
                
            }];
        });
    }
    return (statusCode >= 200 && statusCode <= 299);
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
