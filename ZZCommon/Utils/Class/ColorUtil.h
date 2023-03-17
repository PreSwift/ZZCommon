//
//  ColorUtil.h

//  Created by westMac on 2021/9/15.
//

#import <Foundation/Foundation.h>
#import "ZZCommonMacros.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GradientType) {
    GradientFromTopToBottom,
    GradientFromLeftToRight,
    GradientFromLeftTopToRightBottom,
    GradientFromLeftBottomToRightTop
};

typedef NS_ENUM(NSInteger, GradientColorDirection) {
    GradientColorDirectionLevel,//水平渐变
    GradientColorDirectionVertical,//竖直渐变
    GradientColorDirectionDownDiagonalLine,//向上对角线渐变
    GradientColorDirectionUpwardDiagonalLine,//向下对角线渐变
};

@interface ColorUtil : NSObject

//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

// 创建一张渐变色图片
+ (UIImage *)createImageSize:(CGSize)imageSize gradientColors:(NSArray *)colors percentage:(NSArray *)percents gradientType:(GradientType)gradientType;

@end

@interface UIColor (RGBA)

/**
 *  将当前色值转换为hex字符串，通道排序是RRGGBBAA
 *  @return 色值对应的 hex 字符串，以 # 开头，例如 #00ff00ff
 */
@property(nonatomic, copy, readonly) NSString *rgbaHexString;

/// 设置渐变色
/// @param size 需要渐变的大小
/// @param direction 渐变的方向
/// @param startcolor 渐变的开始颜色
/// @param endColor 渐变的结束颜色
+ (instancetype)gradientColorWithSize:(CGSize)size
                            direction:(GradientColorDirection)direction
                           startColor:(UIColor *)startcolor
                             endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
