//
//  ZZApiHelper+FileUpload.m

//  Created by mac on 2022/3/10.
//

#import "ZZApiHelper+FileUpload.h"
#import "ZZCommonMacros.h"

@implementation ComUploadFileData

- (instancetype)initWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
    self = [super init];
    if (self) {
        self.data = data;
        self.fileName = fileName;
        self.mimeType = mimeType;
    }
    return self;
}

@end

@implementation ComUploadFile

@end



@implementation ZZApiHelper (FileUpload)

+ (NSString *)getFileName {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *currentDateStr = [formatter stringFromDate:NSDate.new];
    NSString *fileName = [NSString stringWithFormat:@"%@_%ld.jpeg", currentDateStr, random()];
    return fileName;
}

/**
 上传单个本地URL文件
 */
- (ZZApiHelper<UploadResponseModel *> *)uploadToServerURL:(NSString *)serverURLStr withFileURL:(NSURL *)fileURL isAudio:(BOOL)isAudio {
    _requestUrl = serverURLStr;
    _requestMethod = YTKRequestMethodPOST;
    _constructingBodyBlock = ^(id<AFMultipartFormData> _Nonnull formData) {
        if (isAudio) {
            NSData *data = [NSData dataWithContentsOfFile:fileURL.absoluteString options:NSDataReadingUncached error:nil];
            [formData appendPartWithFileData:data name:@"file" fileName:fileURL.lastPathComponent mimeType:@"mp3"];
        } else {
            [formData appendPartWithFileURL:fileURL name:@"file" error:nil];
        }
    };
    self.objectBlock = ^NSObject * _Nullable(id  _Nonnull jsonObj) {
        return [UploadResponseModel mj_objectWithKeyValues:jsonObj[@"data"]];
    };
    return self;
}

/**
 上传单个DATA文件
 */
- (ZZApiHelper<UploadResponseModel *> *)uploadToServerURL:(NSString *)serverURLStr withFileData:(ComUploadFileData *)fileData {
    // 图片压缩处理
    NSData *newFileData = fileData.data;
    if (([fileData.mimeType isEqualToString:@".png"]
        || [fileData.mimeType isEqualToString:@".jpg"]
        || [fileData.mimeType isEqualToString:@".jpeg"])
        && fileData.data.length / 1000000 > 2) {
        UIImage *image = [UIImage imageWithData:fileData.data];
        newFileData = UIImageJPEGRepresentation(image, 0.5);
    }
    _requestUrl = serverURLStr;
    _requestMethod = YTKRequestMethodPOST;
    _constructingBodyBlock = ^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:newFileData name:@"file" fileName:fileData.fileName mimeType:@".jpeg"];
    };
    self.objectBlock = ^NSObject * _Nullable(id  _Nonnull jsonObj) {
        return [UploadResponseModel mj_objectWithKeyValues:jsonObj[@"data"]];
    };
    return self;
}

/**
 上传多个文件
 */
+ (void)uploadToServerURL:(NSString *)serverURLStr withFileDatas:(NSArray<ComUploadFile *> *)fileDatas batchRequestTask:(void (^)(YTKBatchRequest * _Nullable))batchRequestTask success:(void (^)(YTKBatchRequest * _Nullable, NSArray<NSString *> * _Nullable))success failure:(void (^)(YTKBatchRequest * _Nullable, ResponseModel * _Nullable))failure {
    if (fileDatas.count == 0) {
        if (success) {
            success(nil, nil);
        }
        return;
    }
    
    [ZZApiHelper getBatchTasks:fileDatas serverURL:serverURLStr block:^(NSArray<ZZApiHelper *> *tasks) {
        YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:tasks];
        if (batchRequestTask) {
            batchRequestTask(batchRequest);
        }
        [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
            NSArray<YTKBaseRequest *> *requests = batchRequest.requestArray;
            NSMutableArray<NSString *> *results = [NSMutableArray arrayWithCapacity:requests.count];
            for (int i=0;i<fileDatas.count;i++) {
                ComUploadFile *obj = fileDatas[i];
                if ((obj.fileData != nil || obj.asset != nil) && obj.fileUrl == nil) {
                    NSString *fileResUrl = [UploadResponseModel mj_objectWithKeyValues:requests[results.count].responseJSONObject[@"data"]].url;
                    obj.fileUrl =  fileResUrl;
                    [results addObject:fileResUrl];
                }
            }
            if (success) {
                success(batchRequest, [fileDatas qmui_mapWithBlock:^id _Nonnull(ComUploadFile * _Nonnull item) {
                    return item.fileUrl;
                }]);
            }
        } failure:^(YTKBatchRequest *batchRequest) {
            if (failure) {
                ResponseModel *responseModel = [ZZApiHelper failureResponseModel:batchRequest.failedRequest];
                failure(batchRequest, responseModel);
            }
        }];
    }];
}

/**
 获取批量任务
 */
+ (void)getBatchTasks:(NSArray<ComUploadFile *> *)fileDatas serverURL:(NSString *)serverURLStr block:(void(^)(NSArray<ZZApiHelper *> *tasks))block {
    NSMutableArray<ZZApiHelper *> *tasks = [NSMutableArray arrayWithCapacity:fileDatas.count];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        for (int i=0;i<fileDatas.count;i++) {
            ComUploadFile *obj = fileDatas[i];
            if (obj.fileData != nil && obj.fileUrl == nil) {
                ZZApiHelper *api = [ZZApiHelper new];
                [api uploadToServerURL:serverURLStr withFileData:obj.fileData];
                [tasks addObject:api];
            } else if (obj.asset != nil && obj.fileUrl == nil) {
                [obj.asset requestOriginImageWithCompletion:^(UIImage *result, NSDictionary<NSString *,id> *info) {
                    if (result) {
                        NSData *imageData = UIImageJPEGRepresentation(result, 0.5);
                        NSString *fileName = [ZZApiHelper getFileName];
                        ZZApiHelper *api = [ZZApiHelper new];
                        [api uploadToServerURL:serverURLStr withFileData:[[ComUploadFileData alloc] initWithData:imageData fileName:fileName mimeType:@".jpeg"]];
                        [tasks addObject:api];
                    }
                    dispatch_semaphore_signal(sema);
                } withProgressHandler:nil];
            }
        }
        
        for (int i=0;i<fileDatas.count;i++) {
            ComUploadFile *obj = fileDatas[i];
            if (obj.asset != nil && obj.fileUrl == nil) {
                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            }
        }
        
        block(tasks);
    });
}

@end
