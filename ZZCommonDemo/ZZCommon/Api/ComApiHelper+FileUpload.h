//
//  ComApiHelper+FileUpload.h
//  jzjx
//
//  Created by mac on 2022/3/10.
//

#import "ComApiHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComUploadFileData : NSObject

/**
 文件数据
 */
@property(nonatomic, strong) NSData *data;

/**
 文件名
 */
@property(nonatomic, strong) NSString *fileName;

/**
 文件格式
 */
@property(nonatomic, strong) NSString *mimeType;


- (instancetype)initWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType;


@end

@interface ComUploadFile : NSObject

/**
 准备上传的数据，与asset二选一
 */
@property(nonatomic, strong) ComUploadFileData *fileData;

/**
 准备上传的图片文件，与fileData二选一
 */
@property(nonatomic, strong) QMUIAsset *asset;

/**
 上传成功后返回的目标链接，如果初始化是就有值，则会忽略此文件
 */
@property(nonatomic, strong) NSString *fileUrl;

@end


@interface ComApiHelper (FileUpload)

/**
 根据时间戳生成文件名
 */
+ (NSString *)getFileName;

/**
 上传单个本地URL文件
 isForBatch:是否为批量上传做数据准备，如果为YES，则success和failure回调无效，可以直接传nil。
 */
- (ComApiHelper<FileUploadResponseModel *> *)uploadWithFileURL:(NSURL *)fileURL isAudio:(BOOL)isAudio;

/**
 上传单个DATA文件
 isForBatch:是否为批量上传做数据准备，如果为YES，则success和failure回调无效，可以直接传nil。
 */
- (ComApiHelper<FileUploadResponseModel *> *)uploadWithFileData:(ComUploadFileData *)fileData;

/**
 上传多个文件
 */
+ (void)uploadWithFileDatas:(NSArray<ComUploadFile *> *)fileDatas
           batchRequestTask:(nullable void (^)(YTKBatchRequest * _Nullable batchRequest))batchRequestTask
                    success:(nullable void (^)(YTKBatchRequest * _Nullable batchRequest, NSArray<NSString *> * _Nullable fileUrls))success
                    failure:(nullable void (^)(YTKBatchRequest * _Nullable batchRequest, ResponseModel * _Nullable responseModel))failure;

@end

NS_ASSUME_NONNULL_END
