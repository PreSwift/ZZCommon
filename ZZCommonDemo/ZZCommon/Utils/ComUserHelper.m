//
//  ComUserHelper.m
//  jzjx
//
//  Created by westMac on 2021/9/24.
//

#import "ComUserHelper.h"
#import "QDTabBarViewController.h"
#import "AppDelegate.h"

@implementation ComUserHelper

+ (ComUserHelper *)shareInstance {
    static dispatch_once_t onceToken;
    static ComUserHelper *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (void)login:(NSString *)username password:(NSString *)password success:(void (^)(UserInfo * _Nullable))success failure:(void (^)(ResponseModel * _Nullable))failure {
    [[[ComApiHelper new] loginWithUsername:username password:password] startWithSuccess:^(YTKBaseRequest * _Nonnull request, LoginModel * _Nullable loginModel) {
        [ComUserHelper enter:loginModel.access_token success:success failure:failure];
    } failure:^(YTKBaseRequest * _Nonnull request, ResponseModel * _Nullable responseModel) {
        if (failure!=NULL) {
            failure(responseModel);
        }
    }];
}

+ (void)enter:(NSString *)accessToken success:(nullable void (^)(UserInfo * _Nullable))success failure:(nullable void (^)(ResponseModel * _Nullable))failure {
    ComUserHelper *userHelper = [ComUserHelper shareInstance];
    // 缓存username和accessToken
    userHelper.accessToken = accessToken;   
    
    [[[ComApiHelper new] getBasicInfoWhenEnter] startWithSuccess:^(YTKBaseRequest * _Nonnull request, UserInfo * _Nullable responseModel) {
        userHelper.userInfo = responseModel;
        
        // 持久化缓存token，方便下次免登录
        [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:@"token"];

        //登录成功
        if (success!=NULL) {
            success(responseModel);
        }
    } failure:^(YTKBaseRequest * _Nonnull request, ResponseModel * _Nullable responseModel) {
        //登录失败
        if (failure!=NULL) {
            failure([[ResponseModel alloc] initWithCode:responseModel.code msg:responseModel.msg]);
        }
    }];
}


+ (void)logoutWithClear:(BOOL)clear {
    ComUserHelper *userHelper = [ComUserHelper shareInstance];
    if (userHelper.accessToken) {
        if (clear) {
            // 退出登录
            [[[ComApiHelper new] logout] startWithSuccess:nil failure:nil];
        }
        [self clearLoginCache];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [ComUserHelper changeRootToLogin];
    });
}

+ (void)changeRootToLogin {
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    [(QDTabBarViewController *)(window.rootViewController) changeRootToLogin];
}

+ (void)clearLoginCache {
    ComUserHelper *userHelper = [ComUserHelper shareInstance];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"token"];
    userHelper.accessToken = nil;
    userHelper.userInfo = nil;
}


+ (BOOL)checkPasswordStrength:(NSString *)password {
    NSString *PATTERN_UPPER_CASE = @".*[A-Z]+.*";
    NSString *PATTERN_LOWER_CASE = @".*[a-z]+.*";
    NSString *PATTERN_NUMBER = @".*[0-9]+.*";
    NSString *PATTERN_SPECIAL_CHAR  = @".*[~!@#$%^&*()_+|<>,.?/:;'\\[\\]{}\"]+.*";
    NSPredicate *pred_UPPER_CASE = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PATTERN_UPPER_CASE];
    NSPredicate *pred_LOWER_CASE = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PATTERN_LOWER_CASE];
    NSPredicate *pred_NUMBER = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PATTERN_NUMBER];
    NSPredicate *pred_SPECIAL_CHAR = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PATTERN_SPECIAL_CHAR];
    BOOL isMatch_UPPER_CASE = [pred_UPPER_CASE evaluateWithObject:password];
    BOOL isMatch_LOWER_CASE = [pred_LOWER_CASE evaluateWithObject:password];
    BOOL isMatch_NUMBER = [pred_NUMBER evaluateWithObject:password];
    BOOL isMatch_SPECIAL_CHAR = [pred_SPECIAL_CHAR evaluateWithObject:password];
    if (!isMatch_UPPER_CASE || !isMatch_LOWER_CASE || !isMatch_NUMBER || !isMatch_SPECIAL_CHAR) {
        [ComUserHelper shareInstance].isWeakPassword = YES;
        return YES;
    }
    return NO;
}

@end
