//
//  IDNameModel.h
//  teacher
//
//  Created by westMac on 2021/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IDNameModel : NSObject

@property(nonatomic, assign) NSInteger ID;
@property(nonatomic, copy) NSString *name;

+ (IDNameModel *)instanceWithID:(NSInteger)ID name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
