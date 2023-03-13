//
//  ComApiHelper+User.h
//  jzjx
//
//  Created by mac on 2022/7/4.
//

#import "ComApiHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComApiHelper (User)

/**
 登录接口
 */
- (ComApiHelper<LoginModel *> *)loginWithUsername:(NSString *)username
                                         password:(NSString *)password;

/**
 退出登录接口
 */
- (ComApiHelper<ResponseModel *> *)logout;

@end

NS_ASSUME_NONNULL_END
