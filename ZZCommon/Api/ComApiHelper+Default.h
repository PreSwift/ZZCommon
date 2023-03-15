//
//  ComApiHelper+Default.h
//  jzjx
//
//  Created by mac on 2022/7/5.
//

#import "ComApiHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComApiHelper (Default)

/**
 发送验证码
 */
- (ComApiHelper<ResponseModel *> *)sendsmscode:(NSString *)phone
                                        userId:(NSString *)userId;
/**
 发送注册验证码
 */
- (ComApiHelper<ResponseModel *> *)sendRegistSmscode:(NSString *)phone
                                              userId:(NSString *)userId;

/**
 校验验证码
 */
- (ComApiHelper<ResponseModel *> *)validatesmscode:(NSString *)code
                                            userId:(NSString *)userId;


/**
 校验注册验证码
 */
- (ComApiHelper<ResponseModel *> *)validateRegistSmscode:(NSString *)code
                                                  userId:(NSString *)userId;

/**
 校验旧密码
 */
- (ComApiHelper<ResponseModel *> *)validatepassword:(NSString *)password;

/**
 进入页面获取基础信息
 */
- (ComApiHelper<UserInfo *> *)getBasicInfoWhenEnter;

/**
 更新pushToken
 */
- (ComApiHelper<ResponseModel *> *)updatePushToken:(NSString *)pushToken;


/**
 获取最新版本
 */
- (ComApiHelper<AppVersionModel *> *)getAppVersion:(int)userType;



/**
 发送邮件
 */
- (ComApiHelper<NSDictionary *> *)sendEmailWithEmail:(NSString *)email
                                                 path:(NSString *)path
                                                title:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
