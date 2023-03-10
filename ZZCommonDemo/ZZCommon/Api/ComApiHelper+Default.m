//
//  ComApiHelper+Default.m
//  jzjx
//
//  Created by mac on 2022/7/5.
//

#import "ComApiHelper+Default.h"

@implementation ComApiHelper (Default)


/**
 发送验证码
 */
- (ComApiHelper<ResponseModel *> *)sendsmscode:(NSString *)phone userId:(NSString *)userId {
    if ([ComUserHelper shareInstance].accessToken) {
        _requestUrl = [NSString stringWithFormat:@"qa/usercenter/sendSmsCodeDirectly?phone=%@&userId=%@", phone, userId];
        _requestMethod = YTKRequestMethodPOST;
    } else {
        _requestUrl = [NSString stringWithFormat:@"qa/usercenter/sendsmscode?phone=%@&userId=%@", phone, userId];
        _requestMethod = YTKRequestMethodPOST;
    }
    return self;
}

/**
 发送注册验证码
 */
- (ComApiHelper<ResponseModel *> *)sendRegistSmscode:(NSString *)phone userId:(NSString *)userId {
    _requestUrl = @"qa/usercenter/sendRegisterSmsCode";
    _requestArgument = @{@"phone": phone, @"userId": userId};
    return self;
}

/**
 校验验证码
 */
- (ComApiHelper<ResponseModel *> *)validatesmscode:(NSString *)code userId:(NSString *)userId {
    _requestUrl = @"qa/usercenter/validatesmscode";
    _requestSerializerType = YTKRequestSerializerTypeHTTP;
    _requestMethod = YTKRequestMethodPOST;
    _requestArgument = @{@"code": code, @"userId": userId};
    return self;
}

/**
 校验注册验证码
 */
- (ComApiHelper<ResponseModel *> *)validateRegistSmscode:(NSString *)code userId:(NSString *)userId {
    _requestUrl = @"qa/usercenter/validateRegisterSmsCode";
    _requestSerializerType = YTKRequestSerializerTypeHTTP;
    _requestMethod = YTKRequestMethodPOST;
    _requestArgument = @{@"code": code, @"userId": userId};
    return self;
}

/**
 校验旧密码
 */
- (ComApiHelper<ResponseModel *> *)validatepassword:(NSString *)password {
    _requestUrl = @"qa/usercenter/validatepassword";
    _requestSerializerType = YTKRequestSerializerTypeHTTP;
    _requestMethod = YTKRequestMethodPOST;
    NSString *aesPassword = [password aci_encryptWithAES];
    _requestArgument = @{@"password": aesPassword};
    return self;
}


/**
 进入页面获取基础信息
 */
- (ComApiHelper<UserInfo *> *)getBasicInfoWhenEnter {
    _requestUrl = @"asset/app/my";
    self.objectBlock = ^NSObject * _Nullable(id  _Nonnull jsonObj) {
        return [UserInfo mj_objectWithKeyValues:jsonObj[@"data"]];
    };
    return self;
}

/**
 更新pushToken
 */
- (ComApiHelper<ResponseModel *> *)updatePushToken:(NSString *)pushToken {
    _requestUrl = @"asset/app/settoken";
    _requestArgument = @{@"pushToken": pushToken};
    return self;
}

/**
 获取最新版本
 */
- (ComApiHelper<AppVersionModel *> *)getAppVersion:(int)userType {
    _requestUrl = @"asset/appversion/getAppVersion";
    self.objectBlock = ^NSObject * _Nullable(id  _Nonnull jsonObj) {
        return [AppVersionModel mj_objectWithKeyValues:jsonObj[@"data"]];
    };
    return self;
}


/**
 发送邮件
 */
- (ComApiHelper<NSDictionary *> *)sendEmailWithEmail:(NSString *)email path:(NSString *)path title:(NSString *)title {
    _requestUrl = @"resource/exampaperplan/email";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:3];
    parameters[@"title"] = title;
    parameters[@"email"] = email;
    parameters[@"path"] = path;
    _requestArgument = parameters;
    self.objectBlock = ^NSObject * _Nullable(id  _Nonnull jsonObj) {
        return jsonObj[@"data"];
    };
    return self;
}


@end
