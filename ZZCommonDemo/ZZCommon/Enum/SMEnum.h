//
//  SMEnum.h
//  SmartManage
//
//  Created by mac on 2023/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMEnum : NSObject

+ (NSString *)getEnumNameFormIDWithDataSource:(NSArray<IDNameModel *> *)dataSource ID:(NSInteger)ID;
+ (NSInteger)getEnumIDFromNameWithDataSource:(NSArray<IDNameModel *> *)dataSource name:(NSString *)name;

/**
 *  角色
 */
+ (NSArray<IDNameModel *> *)getUserRoleArray;
+ (NSString *)getUserRoleNameFromID:(NSInteger)ID;
+ (NSInteger)getUserRoleIDFromName:(NSString *)name;

/**
 *  资产状态
 */
+ (NSArray<IDNameModel *> *)getProperStatusArray;
+ (NSString *)getProperStatusNameFromID:(NSInteger)ID;
+ (NSInteger)getProperStatusIDFromName:(NSString *)name;

/**
 *  流转状态
 */
+ (NSArray<IDNameModel *> *)getMoveStatusArray;
+ (NSString *)getMoveStatusNameFromID:(NSInteger)ID;
+ (NSInteger)getMoveStatusIDFromName:(NSString *)name;

/**
 *  流转原因
 */
+ (NSArray<IDNameModel *> *)getMoveReasonArray;
+ (NSString *)getMoveReasonNameFromID:(NSInteger)ID;
+ (NSInteger)getMoveReasonIDFromName:(NSString *)name;

/**
 *  流转方式
 */
+ (NSArray<IDNameModel *> *)getMoveTypeArray;
+ (NSString *)getMoveTypeNameFromID:(NSInteger)ID;
+ (NSInteger)getMoveTypeIDFromName:(NSString *)name;

/**
 *  维修状态
 */
+ (NSArray<IDNameModel *> *)getMaintainStatusArray;
+ (NSString *)getMaintainStatusNameFromID:(NSInteger)ID;
+ (NSInteger)getMaintainStatusIDFromName:(NSString *)name;

/**
 *  维修方式
 */
+ (NSArray<IDNameModel *> *)getMaintainTypeArray;
+ (NSString *)getMaintainTypeNameFromID:(NSInteger)ID;
+ (NSInteger)getMaintainTypeIDFromName:(NSString *)name;

/**
 *  紧急程度
 */
+ (NSArray<IDNameModel *> *)getUrgencyTypeArray;
+ (NSString *)getUrgencyTypeNameFromID:(NSInteger)ID;
+ (NSInteger)getUrgencyTypeIDFromName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
