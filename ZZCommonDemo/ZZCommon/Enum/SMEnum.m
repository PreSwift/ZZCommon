//
//  SMEnum.m
//  SmartManage
//
//  Created by mac on 2023/2/27.
//

#import "SMEnum.h"

@implementation SMEnum

+ (NSString *)getEnumNameFormIDWithDataSource:(NSArray<IDNameModel *> *)dataSource ID:(NSInteger)ID {
    __block NSString *name = @"";
    [dataSource enumerateObjectsUsingBlock:^(IDNameModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.ID == ID) {
            name = obj.name;
            *stop = YES;
        }
    }];
    return name;
}

+ (NSInteger)getEnumIDFromNameWithDataSource:(NSArray<IDNameModel *> *)dataSource name:(NSString *)name {
    __block NSInteger ID = -1;
    [dataSource enumerateObjectsUsingBlock:^(IDNameModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:name]) {
            ID = obj.ID;
            *stop = YES;
        }
    }];
    return ID;
}

/**
 *  角色
 */
+ (NSArray<IDNameModel *> *)getUserRoleArray {
    return @[
        [IDNameModel instanceWithID:1 name:@"部门负责人"],
        [IDNameModel instanceWithID:2 name:@"部门区域主管"],
        [IDNameModel instanceWithID:3 name:@"所在地主管"],
        [IDNameModel instanceWithID:4 name:@"部门普通员工"],
        [IDNameModel instanceWithID:5 name:@"资产管理员"],
        [IDNameModel instanceWithID:6 name:@"审计管理员"],
        [IDNameModel instanceWithID:11 name:@"技术经理"],
        [IDNameModel instanceWithID:12 name:@"区域维修员"]
    ];
}

+ (NSString *)getUserRoleNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getUserRoleArray] ID:ID];
}

+ (NSInteger)getUserRoleIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getUserRoleArray] name:name];
}


/**
 *  资产状态
 */
+ (NSArray<IDNameModel *> *)getProperStatusArray {
    return @[
        [IDNameModel instanceWithID:0 name:@"闲置"],
        [IDNameModel instanceWithID:1 name:@"使用中"],
        [IDNameModel instanceWithID:2 name:@"待维修"],
        [IDNameModel instanceWithID:3 name:@"维修中"],
        [IDNameModel instanceWithID:4 name:@"已维修"],
        [IDNameModel instanceWithID:5 name:@"待报废"],
        [IDNameModel instanceWithID:6 name:@"已报废"]
    ];
}

+ (NSString *)getProperStatusNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getProperStatusArray] ID:ID];
}

+ (NSInteger)getProperStatusIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getProperStatusArray] name:name];
}

/**
 *  流转状态
 */
+ (NSArray<IDNameModel *> *)getMoveStatusArray {
    return @[
        [IDNameModel instanceWithID:0 name:@"待接收"],
        [IDNameModel instanceWithID:1 name:@"已接收"]
    ];
}

+ (NSString *)getMoveStatusNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getMoveStatusArray] ID:ID];
}

+ (NSInteger)getMoveStatusIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getMoveStatusArray] name:name];
}

/**
 *  流转原因
 */
+ (NSArray<IDNameModel *> *)getMoveReasonArray {
    return @[
        [IDNameModel instanceWithID:0 name:@"维修"],
        [IDNameModel instanceWithID:1 name:@"借调"],
        [IDNameModel instanceWithID:2 name:@"转移"]
    ];
}

+ (NSString *)getMoveReasonNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getMoveReasonArray] ID:ID];
}

+ (NSInteger)getMoveReasonIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getMoveReasonArray] name:name];
}

/**
 *  流转方式
 */
+ (NSArray<IDNameModel *> *)getMoveTypeArray {
    return @[
        [IDNameModel instanceWithID:1 name:@"普通"],
        [IDNameModel instanceWithID:2 name:@"快递"]
    ];
}

+ (NSString *)getMoveTypeNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getMoveTypeArray] ID:ID];
}

+ (NSInteger)getMoveTypeIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getMoveTypeArray] name:name];
}

/**
 *  维修状态
 */
+ (NSArray<IDNameModel *> *)getMaintainStatusArray {
    return @[
        [IDNameModel instanceWithID:0 name:@"待维修"],
        [IDNameModel instanceWithID:1 name:@"维修中"],
        [IDNameModel instanceWithID:2 name:@"维修完成"],
        [IDNameModel instanceWithID:3 name:@"已确认"],
        [IDNameModel instanceWithID:4 name:@"无法维修"]
    ];
}

+ (NSString *)getMaintainStatusNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getMaintainStatusArray] ID:ID];
}

+ (NSInteger)getMaintainStatusIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getMaintainStatusArray] name:name];
}

/**
 *  维修方式
 */
+ (NSArray<IDNameModel *> *)getMaintainTypeArray {
    return @[
        [IDNameModel instanceWithID:1 name:@"现场维修"],
        [IDNameModel instanceWithID:2 name:@"远程维修"],
        [IDNameModel instanceWithID:3 name:@"返回公司维修"],
        [IDNameModel instanceWithID:4 name:@"返厂维修"]
    ];
}

+ (NSString *)getMaintainTypeNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getMaintainTypeArray] ID:ID];
}

+ (NSInteger)getMaintainTypeIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getMaintainTypeArray] name:name];
}

/**
 *  紧急程度
 */
+ (NSArray<IDNameModel *> *)getUrgencyTypeArray {
    return @[
        [IDNameModel instanceWithID:1 name:@"高"],
        [IDNameModel instanceWithID:2 name:@"中"],
        [IDNameModel instanceWithID:3 name:@"低"]
    ];
}

+ (NSString *)getUrgencyTypeNameFromID:(NSInteger)ID {
    return [SMEnum getEnumNameFormIDWithDataSource:[SMEnum getUrgencyTypeArray] ID:ID];
}

+ (NSInteger)getUrgencyTypeIDFromName:(NSString *)name {
    return [SMEnum getEnumIDFromNameWithDataSource:[SMEnum getUrgencyTypeArray] name:name];
}


@end
