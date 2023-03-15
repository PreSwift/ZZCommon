//
//  FileUploadResponseModel.h
//  jzjx
//
//  Created by west007 on 2021/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileUploadResponseModel : NSObject

@property(nonatomic, copy) NSString *url;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@end

NS_ASSUME_NONNULL_END
