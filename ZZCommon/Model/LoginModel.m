//
//  LoginModel.m
//  jzjx
//
//  Created by west007 on 2021/7/13.
//

#import "LoginModel.h"

@implementation UserRoleModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName {
    return@{@"ID":@"id"};
}

@end

@implementation UserInfo

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"roleList":UserRoleModel.class};
}

@end

@implementation LoginModel

@end
