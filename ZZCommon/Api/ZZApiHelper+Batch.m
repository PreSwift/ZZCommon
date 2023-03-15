//
//  ZZApiHelper+Batch.m
//  student
//
//  Created by mac on 2022/8/5.
//

#import "ZZApiHelper+Batch.h"

@implementation ZZApiHelper (Batch)

+ (void)batchResponseModel:(YTKBatchRequest *)batchRequest success:(void (^)(YTKBatchRequest * _Nonnull, NSArray * _Nullable))success failure:(void (^)(YTKBatchRequest * _Nonnull, ResponseModel * _Nullable))failure {
    NSArray<YTKBaseRequest *> *requests = batchRequest.requestArray;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:requests.count];
    for (ZZApiHelper *comApi in requests) {
        RACTuple *responseModel = [ZZApiHelper successResponseModel:comApi];
        if ([responseModel.first boolValue]) {
            [result addObject:responseModel.second];
        } else {
            if (failure) {
                failure(batchRequest, responseModel.second);
            }
            return;
        }
    }
    if (result.count == requests.count) {
        if (success) {
            success(batchRequest, result);
        }
    }
}

@end
