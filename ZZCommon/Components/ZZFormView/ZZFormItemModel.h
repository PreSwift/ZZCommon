//
//  ZZFormItemModel.h
//  jzjx
//
//  Created by Ethan on 2022/9/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZFormItemModel : NSObject

/**
 文本最大显示行，默认0，即无限制
 */
@property(nonatomic, assign) BOOL numberOfLines;

/**
 文本对齐方式，默认居中
 */
@property(nonatomic, assign) NSTextAlignment textAlignment;

/**
 边距，默认（4， 4， 4， 4）
 */
@property(nonatomic, assign) UIEdgeInsets contentPadding;

/**
 宽度
 */
@property(nonatomic, assign) CGFloat itemWidth;

/**
 高度，根据文本自动计算的
 */
@property(nonatomic, assign, readonly) CGFloat itemHeight;

/**
 字体，默认12
 */
@property(nonatomic, strong) UIFont *textFont;

/**
 字体颜色
 */
@property(nonatomic, strong) UIColor *textColor;

/**
 背景颜色
 */
@property(nonatomic, strong) UIColor *backgroundColor;

/**
 是否允许点击单元格
 */
@property(nonatomic, assign) BOOL tapCellEnabled;

/**
 显示的文本
 */
@property(nonatomic, strong) NSString *content;

/**
 显示的文本
 */
@property(nonatomic, strong) NSMutableAttributedString *attributedContent;

/**
 装饰图片
 */
@property(nonatomic, strong) UIImage *accessoryImage;

/**
 装饰图片位置，默认左边QMUIButtonImagePositionLeft
 */
@property(nonatomic, assign) QMUIButtonImagePosition accessoryImagePosition;

/**
 装饰图片与文本之间的距离， 默认5
 */
@property(nonatomic, assign) CGFloat spacingBetweenAccessoryImageAndContent;

- (instancetype)initWithContent:(nullable NSString *)content
                 accessoryImage:(nullable UIImage *)accessoryImage
                      itemWidth:(CGFloat)itemWidth;

- (instancetype)initWithAttributedContent:(nullable NSMutableAttributedString *)attributedContent
                           accessoryImage:(nullable UIImage *)accessoryImage
                                itemWidth:(CGFloat)itemWidth;


@end

NS_ASSUME_NONNULL_END
