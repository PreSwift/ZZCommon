//
//  ResponseModel.h
//  jzjx
//
//  Created by west007 on 2021/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResponseModel : NSObject

@property(assign, nonatomic) NSInteger code;
@property(copy, nonatomic, nullable) NSString *msg;
@property(strong, nonatomic, nullable) id data;

- (instancetype)initWithCode:(NSInteger)code msg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
