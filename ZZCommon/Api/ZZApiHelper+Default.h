//
//  ZZApiHelper+Default.h

//  Created by mac on 2022/7/5.
//

#import "ZZApiHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZApiHelper (Default)

/**
 发送验证码
 */
- (ZZApiHelper<ResponseModel *> *)sendsmscode:(NSString *)phone
                                        userId:(NSString *)userId;
/**
 发送注册验证码
 */
- (ZZApiHelper<ResponseModel *> *)sendRegistSmscode:(NSString *)phone
                                              userId:(NSString *)userId;

/**
 校验验证码
 */
- (ZZApiHelper<ResponseModel *> *)validatesmscode:(NSString *)code
                                            userId:(NSString *)userId;


/**
 校验注册验证码
 */
- (ZZApiHelper<ResponseModel *> *)validateRegistSmscode:(NSString *)code
                                                  userId:(NSString *)userId;

/**
 校验旧密码
 */
- (ZZApiHelper<ResponseModel *> *)validatepassword:(NSString *)password;

/**
 进入页面获取基础信息
 */
- (ZZApiHelper<UserInfo *> *)getBasicInfoWhenEnter;

/**
 更新pushToken
 */
- (ZZApiHelper<ResponseModel *> *)updatePushToken:(NSString *)pushToken;


/**
 获取最新版本
 */
- (ZZApiHelper<AppVersionModel *> *)getAppVersion:(int)userType;



/**
 发送邮件
 */
- (ZZApiHelper<NSDictionary *> *)sendEmailWithEmail:(NSString *)email
                                                 path:(NSString *)path
                                                title:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
