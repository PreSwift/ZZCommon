//
//  ResponseModel.m
//  jzjx
//
//  Created by west007 on 2021/7/15.
//

#import "ResponseModel.h"

@implementation ResponseModel

- (instancetype)initWithCode:(NSInteger)code msg:(NSString *)msg {
    self = [super init];
    if (self) {
        _code = code;
        _msg = msg;
    }
    return self;
}

- (void)mj_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues {
    if ([_msg containsString:@"[500 Internal Server Error]"]) {
        _msg = @"服务器内部错误，请稍后再试";
    }
}

@end
