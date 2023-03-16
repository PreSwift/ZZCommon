//
//  ZZApiHelper.h

//  Created by westMac on 2021/8/18.
//

#import "ZZApiHeader.h"

extern NSString * _Nullable BASE_HOST;
extern NSString * _Nullable BASE_WEB_HOST;
extern NSString * _Nullable CDN_HOST;

NS_ASSUME_NONNULL_BEGIN

typedef NSObject * _Nullable(^ComApiObjectBlock)(id jsonObj);

@interface ZZApiHelper<__covariant T:NSObject *> : YTKRequest
{
    NSString *_requestUrl;
    YTKRequestMethod _requestMethod;
    id _requestArgument;
    NSDictionary<NSString *,NSString *> *_requestHeaderFieldValueDictionary;
    NSInteger _requestTimeoutInterval;
    NSInteger _cacheTimeInSeconds;
    YTKRequestSerializerType _requestSerializerType;
    YTKResponseSerializerType _responseSerializerType;
    AFConstructingBlock _constructingBodyBlock;
    NSURLRequest *_buildCustomUrlRequest;
}

@property (nonatomic, copy, nullable) ComApiObjectBlock objectBlock;

/**
 通用处理方式
 */
- (void)startWithSuccess:(nullable void (^)(YTKBaseRequest *request, T _Nullable responseModel))success
                 failure:(nullable void (^)(YTKBaseRequest *request, ResponseModel * _Nullable responseModel))failure;

/**
 通用添加公共参数Header
 */
+ (nullable NSDictionary <NSString *, NSString *> *)handleHeaders:(NSDictionary <NSString *, NSString *>  * _Nullable)oldHeaders;

/**
 通用处理错误msg
 */
+ (NSString *)handleResponseMsg:(NSInteger)responseStatusCode;

/**
 解析successRequest
 返回的是元祖，共两个参数
 第一个参数是NSBoolValue，代表成功与否
 第二个参数是解析出来的model
 */
+ (RACTuple *)successResponseModel:(ZZApiHelper *)successRequest;

/**
 获取错误responseModel
 */
+ (nullable ResponseModel *)failureResponseModel:(YTKRequest *)failureRequest;

/**
 设置Host
 */
+ (void)configForBaseHost:(NSString *)baseHost baseWebHost:(nullable NSString *)baseWebHost cdnHost:(nullable NSString *)cdnHost;

@end

NS_ASSUME_NONNULL_END
