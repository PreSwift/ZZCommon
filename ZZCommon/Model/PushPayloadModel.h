//
//  PushPayloadModel.h
//  ZZCommon
//
//  Created by mac on 2023/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertModel : NSObject

@property(nonatomic, strong) NSString * body;
@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) NSString *subtitle;

@end

@interface ApsModel : NSObject

@property(nonatomic, assign) NSInteger badge;
@property(nonatomic, strong) NSString * sound;
@property(nonatomic, strong) AlertModel *alert;


@end

@interface PushPayloadModel : NSObject

@property(nonatomic, assign) NSInteger messageType;
@property(nonatomic, assign) NSInteger objId;
@property(nonatomic, strong) ApsModel *aps;

@end

NS_ASSUME_NONNULL_END
