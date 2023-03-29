//
//  ZZApiHelper.m

//  Created by westMac on 2021/8/18.
//

#import "ZZApiHelper.h"
#import "ZZCommonMacros.h"

NSString * _Nullable BASE_HOST;
NSString * _Nullable BASE_WEB_HOST;
NSString * _Nullable CDN_HOST;

HeaderHandleBlock headerHandleBlock;
StatusCodeValidatorBlock statusCodeValidatorBlock;

typedef void(^ComApiSuccessBlock)(__kindof YTKBaseRequest *request, __kindof NSObject * _Nullable obj);
typedef void(^ComApiFailureBlock)(__kindof YTKBaseRequest *request, ResponseModel * _Nullable responseModel);

@interface ZZApiHelper ()

@property (nonatomic, copy, nullable) ComApiSuccessBlock successBlock;
@property (nonatomic, copy, nullable) ComApiFailureBlock failureBlock;

@end

@implementation ZZApiHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestMethod = YTKRequestMethodGET;
        _requestTimeoutInterval = 20;
        _cacheTimeInSeconds = -1;
        _requestSerializerType = YTKRequestSerializerTypeJSON;
        _responseSerializerType = YTKResponseSerializerTypeJSON;
    }
    return self;
}

- (void)dealloc {
//    NSLog(@"请求%@释放了", self.requestUrl);
}

- (NSString *)requestUrl {
    return _requestUrl;
}

- (YTKRequestMethod)requestMethod {
    return _requestMethod;
}

- (id)requestArgument {
    return _requestArgument;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    NSAssert(headerHandleBlock, @"请先配置公共header逻辑，configForDefaultHeader:");
    return headerHandleBlock(_requestHeaderFieldValueDictionary);
}

- (NSTimeInterval)requestTimeoutInterval {
    return _requestTimeoutInterval;
}

- (NSInteger)cacheTimeInSeconds {
    return _cacheTimeInSeconds;
}

- (YTKRequestSerializerType)requestSerializerType {
    return _requestSerializerType;
}

- (YTKResponseSerializerType)responseSerializerType {
    return _responseSerializerType;
}

- (AFConstructingBlock)constructingBodyBlock {
    return _constructingBodyBlock;
}

- (NSURLRequest *)buildCustomUrlRequest {
    return _buildCustomUrlRequest;
}

/**
 清空回调，解除block
 */
- (void)clearCompletionBlock {
    [super clearCompletionBlock];
    self.successBlock = nil;
    self.failureBlock = nil;
}

- (BOOL)statusCodeValidator {
    if (!statusCodeValidatorBlock) {
        NSInteger statusCode = [self responseStatusCode];
        return (statusCode >= 200 && statusCode <= 299);
    } else {
        return statusCodeValidatorBlock(self);
    }
}

/**
 通用处理方式
 */
- (void)startWithSuccess:(void (^)(YTKBaseRequest * _Nonnull, NSObject * _Nullable))success failure:(void (^)(YTKBaseRequest * _Nonnull, ResponseModel * _Nullable))failure {
    _successBlock = success;
    _failureBlock = failure;
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        RACTuple *responseModel = [ZZApiHelper successResponseModel:request];
        if ([responseModel.first boolValue]) {
            if (success) {
                success(request, responseModel.second);
            }
        } else {
            if (failure) {
                failure(request, responseModel.second);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            ResponseModel *responseModel = [ZZApiHelper failureResponseModel:request];
            failure(request, responseModel);
        }
    }];
}

/**
 配置公共Header处理
 */
+ (void)configForDefaultHeader:(HeaderHandleBlock)block {
    headerHandleBlock = block;
}

/**
 配置公共StatusCode处理
 */
+ (void)configForStatusCodeValidator:(StatusCodeValidatorBlock)block {
    statusCodeValidatorBlock = block;
}

/**
 通用处理错误msg
 */
+ (NSString *)handleResponseMsg:(YTKRequest *)failRequest {
    NSString *errorMsg = @"未知错误";
    if (failRequest.error.localizedDescription.length > 0) {
        errorMsg = failRequest.error.localizedDescription;
    } else {
        switch (failRequest.error.code) {
            case -1://NSURLErrorUnknown
                errorMsg = @"未知错误";
                break;
            case -999://NSURLErrorCancelled
                errorMsg = @"无效的URL地址";
                break;
            case -1000://NSURLErrorBadURL
                errorMsg = @"无效的URL地址";
                break;
            case -1001://NSURLErrorTimedOut
                errorMsg = @"请求超时，请刷新重试";
                break;
            case -1002://NSURLErrorUnsupportedURL
                errorMsg = @"不支持的URL地址";
                break;
            case -1003://NSURLErrorCannotFindHost
                errorMsg = @"找不到服务器";
                break;
            case -1004://NSURLErrorCannotConnectToHost
                errorMsg = @"连接不上服务器";
                break;
            case -1103://NSURLErrorDataLengthExceedsMaximum
                errorMsg = @"请求数据长度超出最大限度";
                break;
            case -1005://NSURLErrorNetworkConnectionLost
                errorMsg = @"网络异常，请检查网络";
                break;
            case -1006://NSURLErrorDNSLookupFailed
                errorMsg = @"DNS查询失败";
                break;
            case -1007://NSURLErrorHTTPTooManyRedirects
                errorMsg = @"HTTP请求重定向";
                break;
            case -1008://NSURLErrorResourceUnavailable
                errorMsg = @"资源不可用";
                break;
            case -1009://NSURLErrorNotConnectedToInternet
                errorMsg = @"网络异常，请检查网络";
                break;
            case -1010://NSURLErrorRedirectToNonExistentLocation
                errorMsg = @"重定向到不存在的位置";
                break;
            case -1011://NSURLErrorBadServerResponse
                errorMsg = @"服务器响应异常";
                break;
            case -1012://NSURLErrorUserCancelledAuthentication
                errorMsg = @"用户取消授权";
                break;
            case -1013://NSURLErrorUserAuthenticationRequired
                errorMsg = @"需要用户授权";
                break;
            case -1014://NSURLErrorZeroByteResource
                errorMsg = @"零字节资源";
                break;
            case -1015://NSURLErrorCannotDecodeRawData
                errorMsg = @"无法解码原始数据";
                break;
            case -1016://NSURLErrorCannotDecodeContentData
                errorMsg = @"无法解码内容数据";
                break;
            case -1017://NSURLErrorCannotParseResponse
                errorMsg = @"无法解析响应";
                break;
            case -1018://NSURLErrorInternationalRoamingOff
                errorMsg = @"国际漫游关闭";
                break;
            case -1019://NSURLErrorCallIsActive
                errorMsg = @"被叫激活";
                break;
            case -1020://NSURLErrorDataNotAllowed
                errorMsg = @"网络异常，请检查网络";
                break;
            case -1021://NSURLErrorRequestBodyStreamExhausted
                errorMsg = @"请求数据包丢失";
                break;
            case -1100://NSURLErrorFileDoesNotExist
                errorMsg = @"文件不存在";
                break;
            case -1101://NSURLErrorFileIsDirectory
                errorMsg = @"文件是个目录";
                break;
            case -1102://NSURLErrorNoPermissionsToReadFile
                errorMsg = @"无读取文件权限";
                break;
            case -1200://NSURLErrorSecureConnectionFailed
                errorMsg = @"安全连接失败";
                break;
            case -1201://NSURLErrorServerCertificateHasBadDate
                errorMsg = @"服务器证书失效";
                break;
            case -1202://NSURLErrorServerCertificateUntrusted
                errorMsg = @"不被信任的服务器证书";
                break;
            case -1203://NSURLErrorServerCertificateHasUnknownRoot
                errorMsg = @"未知Root的服务器证书";
                break;
            case -1204://NSURLErrorServerCertificateNotYetValid
                errorMsg = @"服务器证书未生效";
                break;
            case -1205://NSURLErrorClientCertificateRejected
                errorMsg = @"客户端证书被拒";
                break;
            case -1206://NSURLErrorClientCertificateRequired
                errorMsg = @"需要客户端证书";
                break;
            case -2000://NSURLErrorCannotLoadFromNetwork
                errorMsg = @"无法从网络获取";
                break;
            case -3000://NSURLErrorCannotCreateFile
                errorMsg = @"无法创建文件";
                break;
            case -3001:// NSURLErrorCannotOpenFile
                errorMsg = @"无法打开文件";
                break;
            case -3002://NSURLErrorCannotCloseFile
                errorMsg = @"无法关闭文件";
                break;
            case -3003://NSURLErrorCannotWriteToFile
                errorMsg = @"无法写入文件";
                break;
            case -3004://NSURLErrorCannotRemoveFile
                errorMsg = @"无法删除文件";
                break;
            case -3005://NSURLErrorCannotMoveFile
                errorMsg = @"无法移动文件";
                break;
            case -3006://NSURLErrorDownloadDecodingFailedMidStream
                errorMsg = @"下载解码数据失败";
                break;
            case -3007://NSURLErrorDownloadDecodingFailedToComplete
                errorMsg = @"下载解码数据失败";
                break;
        }
    }
    
    return errorMsg;
}

/**
 解析successRequest
 返回的是元祖，共两个参数
 第一个参数是NSBoolValue，代表成功与否
 第二个参数是解析出来的model
 */
+ (RACTuple *)successResponseModel:(ZZApiHelper *)successRequest {
    ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:successRequest.responseJSONObject];
    if (responseModel.code == 0) {
        return [RACTuple tupleWithObjects:@YES, successRequest.objectBlock ? successRequest.objectBlock(successRequest.responseJSONObject) : responseModel, nil];
    } else {
        return [RACTuple tupleWithObjects:@NO, responseModel, nil];
    }
}

/**
 获取错误responseModel
 */
+ (ResponseModel *)failureResponseModel:(YTKRequest *)failureRequest {
    ResponseModel *responseModel = [ResponseModel mj_objectWithKeyValues:failureRequest.responseJSONObject];
    if (!responseModel) {
        responseModel = [[ResponseModel alloc] initWithCode:failureRequest.responseStatusCode msg:[ZZApiHelper handleResponseMsg:failureRequest]];
    } else {
        if (responseModel.msg.length > 30 && failureRequest.error.localizedDescription.length > 0) {
            responseModel.msg = failureRequest.error.localizedDescription;
        }
    }
    return responseModel;
}

+ (void)configForBaseHost:(NSString *)baseHost baseWebHost:(NSString *)baseWebHost cdnHost:(NSString *)cdnHost {
    BASE_HOST = baseHost;
    BASE_WEB_HOST = baseWebHost;
    CDN_HOST = cdnHost;
    // 网络请求通用参数设置
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = BASE_HOST;
    config.cdnUrl = CDN_HOST;
}

@end
