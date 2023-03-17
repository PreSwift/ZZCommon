//
//  ZZEnumBase.h
//  ZZCommon
//
//  Created by mac on 2023/2/27.
//

#import <Foundation/Foundation.h>
#import "IDNameModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZEnum : NSObject

+ (NSString *)getEnumNameFormIDWithDataSource:(NSArray<IDNameModel *> *)dataSource ID:(NSInteger)ID;
+ (NSInteger)getEnumIDFromNameWithDataSource:(NSArray<IDNameModel *> *)dataSource name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
