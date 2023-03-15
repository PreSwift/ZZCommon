//
//  UIView+Extension.h
//  student
//
//  Created by westMac on 2021/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

- (UIView * _Nullable)topSubviewInLocation: (CGPoint)location;

- (void)setBorderWithTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

@property(nonatomic, strong, nullable) CALayer *topBorderLayer;
@property(nonatomic, strong, nullable) CALayer *bottomBorderLayer;
@property(nonatomic, strong, nullable) CALayer *leftBorderLayer;
@property(nonatomic, strong, nullable) CALayer *rightBorderLayer;

@end

NS_ASSUME_NONNULL_END
