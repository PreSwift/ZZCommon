//
//  ZZEnumBase.m
//  ZZCommon
//
//  Created by mac on 2023/2/27.
//

#import "ZZEnumBase.h"

@implementation ZZEnum

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

@end
