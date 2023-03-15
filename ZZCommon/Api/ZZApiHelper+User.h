//
//  ZZApiHelper+User.h

//  Created by mac on 2022/7/4.
//

#import "ZZApiHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZApiHelper (User)

/**
 登录接口
 */
- (ZZApiHelper<LoginModel *> *)loginWithUsername:(NSString *)username
                                         password:(NSString *)password;

/**
 退出登录接口
 */
- (ZZApiHelper<ResponseModel *> *)logout;

@end

NS_ASSUME_NONNULL_END
