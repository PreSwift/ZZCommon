//
//  ZZApiHelper+Batch.h
//  student
//
//  Created by mac on 2022/8/5.
//

#import "ZZApiHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZApiHelper (Batch)

/**
 解析batchSuccessRequest
 */
+ (void)batchResponseModel:(YTKBatchRequest *)batchRequest
                   success:(nullable void (^)(YTKBatchRequest *batchRequest, NSArray * _Nullable responseModels))success
                   failure:(nullable void (^)(YTKBatchRequest *batchRequest, ResponseModel * _Nullable responseModel))failure;

@end

NS_ASSUME_NONNULL_END
