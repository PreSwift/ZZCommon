//
//  IDNameModel.m

//  Created by westMac on 2021/9/14.
//

#import "IDNameModel.h"

@implementation IDNameModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName {
    return@{@"ID":@"id"};
}

+ (NSArray *)mj_ignoredCodingPropertyNames {
    return  @[@"subObjects"];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return  @[@"subObjects"];
}

+ (IDNameModel *)instanceWithID:(NSInteger)ID name:(NSString *)name {
    IDNameModel *idNameModel = [[IDNameModel alloc] init];
    idNameModel.ID = ID;
    idNameModel.name = name;
    return idNameModel;
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if ([super isEqual:other]) {
        return YES;
    } else {
        if ([other isKindOfClass:[IDNameModel class]]) {
            return other != nil && self.ID == ((IDNameModel *)other).ID && [self.name isEqualToString:((IDNameModel *)other).name];
        } else {
            return NO;
        }
    }
}

- (NSUInteger)hash
{
    return [self.name hash] ^ self.ID;
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    if (!_name) {
        _name = @"";
    }
}


@end
