//
//  ZZApiHelper+User.m

//  Created by mac on 2022/7/4.
//

#import "ZZApiHelper+User.h"
#import "ZZCommonMacros.h"

@implementation ZZApiHelper (User)

/**
 登录接口
 */
- (ZZApiHelper<LoginModel *> *)loginWithUsername:(NSString *)username password:(NSString *)password {
    _requestUrl = @"auth/oauth2/token?grant_type=password&scope=server";
    _requestMethod = YTKRequestMethodPOST;
    NSString *authorization = @"Basic cGlnOnBpZw==";
    _requestHeaderFieldValueDictionary = @{@"Authorization": authorization, @"isToken": @"false"};
    NSString *aesPassword = [password aci_encryptWithAES];
    _requestArgument = @{@"username":[username qmui_stringByEncodingUserInputQuery], @"password":aesPassword};
    _requestSerializerType = YTKRequestSerializerTypeHTTP;
    self.objectBlock = ^NSObject * _Nullable(id  _Nonnull jsonObj) {
        return [LoginModel mj_objectWithKeyValues:jsonObj];
    };
    return self;
}

/**
 退出登录接口
 */
- (ZZApiHelper<ResponseModel *> *)logout {
    _requestUrl = @"auth/token/logout";
    _requestMethod = YTKRequestMethodDELETE;
    return self;
}

@end
