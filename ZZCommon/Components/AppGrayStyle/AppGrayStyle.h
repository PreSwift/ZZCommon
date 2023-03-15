//
//  AppGrayStyle.h

//  Created by mac on 2022/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppGrayStyle : NSObject

/// 开启全局变灰
+ (void)open;

/// 关闭全局变灰
+ (void)close;

/// 添加灰色模式
+ (void)addToView:(UIView *)view;

/// 移除灰色模式
+ (void)removeFromView:(UIView *)view;


@end

NS_ASSUME_NONNULL_END
