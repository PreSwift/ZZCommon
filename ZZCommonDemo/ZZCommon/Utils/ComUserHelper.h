//
//  ComComUserHelper.h
//  jzjx
//
//  Created by westMac on 2021/9/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComUserHelper : NSObject

@property (nonatomic, strong, nullable) AppVersionModel *appVersion;
@property (nonatomic, copy, nullable) NSString *accessToken;
@property (nonatomic, strong, nullable) UserInfo *userInfo;
@property (nonatomic, copy) NSString *notification; //维护提示文字，如果不为空，则显示提醒弹窗。
@property (nonatomic, assign) BOOL isWeakPassword; //是否是弱密码
@property (nonatomic, assign) BOOL hasShowOverdue; //是否已经有显示登录凭证过期的提示窗
@property (nonatomic, assign) BOOL needToReserPassword; //是否需要跳转到修改密码，首次进入首页的时候用

+ (ComUserHelper *)shareInstance;

+ (void)login:(nonnull NSString*)username
     password:(nonnull NSString*)password
      success:(nullable void (^)(UserInfo * _Nullable userInfo))success
      failure:(nullable void (^)(ResponseModel * _Nullable responseModel))failure;

+ (void)enter:(nonnull NSString *)accessToken
      success:(nullable void (^)(UserInfo * _Nullable userInfo))success
      failure:(nullable void (^)(ResponseModel * _Nullable responseModel))failure;

+ (void)logoutWithClear:(BOOL)clear;

+ (void)changeRootToLogin;

+ (void)clearLoginCache;

+ (BOOL)checkPasswordStrength:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
