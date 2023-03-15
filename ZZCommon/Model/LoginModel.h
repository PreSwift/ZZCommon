//
//  LoginModel.h
//  jzjx
//
//  Created by west007 on 2021/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserRoleModel : NSObject

@property(assign, nonatomic) NSInteger ID;
@property(assign, nonatomic) NSInteger employeeId;
@property(assign, nonatomic) NSInteger type;
@property(assign, nonatomic) NSInteger deptId;
@property(assign, nonatomic) NSInteger areaId;
@property(assign, nonatomic) NSInteger placeIds;
@property(copy, nonatomic) NSString* placeNames;
@property(copy, nonatomic) NSString* areaName;
@property(copy, nonatomic) NSString* deptName;

@end

@interface UserInfo : NSObject

@property(copy, nonatomic) NSString* username;
@property(assign, nonatomic) NSInteger employeeId;
@property(copy, nonatomic) NSString* employeeName;
@property(assign, nonatomic) NSInteger deptId;
@property(copy, nonatomic) NSString* deptName;
@property(copy, nonatomic) NSString* types;
@property(copy, nonatomic) NSString* avatar;
@property(strong, nonatomic) NSArray<UserRoleModel *> *roleList;

@end

@interface LoginModel : NSObject

@property (copy, nonatomic) NSString *access_token;

@end

NS_ASSUME_NONNULL_END
