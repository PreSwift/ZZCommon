//
//  AppVersionModel.h
//  jzjx
//
//  Created by westMac on 2021/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppVersionModel : NSObject

@property(nonatomic, assign) int version;
@property(nonatomic, copy) NSString *link;
@property(nonatomic, assign) int forcedUpdate;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *remarks;

@end

NS_ASSUME_NONNULL_END
