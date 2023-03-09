//
//  UIView+Extension.m
//  student
//
//  Created by westMac on 2021/10/15.
//

#import "UIView+Extension.h"


@implementation UIView (Extension)

- (void)setLeftBorderLayer:(CALayer *)leftBorderLayer {
    objc_setAssociatedObject(self, "leftBorderLayer", leftBorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)leftBorderLayer {
    return objc_getAssociatedObject(self, "leftBorderLayer");
}

- (void)setRightBorderLayer:(CALayer *)rightBorderLayer {
    objc_setAssociatedObject(self, "rightBorderLayer", rightBorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)rightBorderLayer {
    return objc_getAssociatedObject(self, "rightBorderLayer");
}

- (void)setBottomBorderLayer:(CALayer *)bottomBorderLayer {
    objc_setAssociatedObject(self, "bottomBorderLayer", bottomBorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)bottomBorderLayer {
    return objc_getAssociatedObject(self, "bottomBorderLayer");
}

- (void)setTopBorderLayer:(CALayer *)topBorderLayer {
    objc_setAssociatedObject(self, "topBorderLayer", topBorderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)topBorderLayer {
    return objc_getAssociatedObject(self, "topBorderLayer");
}

- (UIView *)topSubviewInLocation:(CGPoint)location {
    NSArray<UIView *> *subviews = self.subviews;
    if (subviews && subviews.count > 0) {
        for (int i=((int)subviews.count - 1); i>=0; i--) {
            UIView *subview = subviews[i];
            if (location.x >= subview.qmui_left &&
                location.y >= subview.qmui_top &&
                location.x <= subview.qmui_left + subview.qmui_width &&
                location.y <= subview.qmui_top + subview.qmui_height
                ) {
                return subview;
            }
        }
    }
    return nil;
}

- (void)setBorderWithTop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    [self.topBorderLayer removeFromSuperlayer];
    [self.bottomBorderLayer removeFromSuperlayer];
    [self.leftBorderLayer removeFromSuperlayer];
    [self.rightBorderLayer removeFromSuperlayer];
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        self.topBorderLayer = layer;
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        self.leftBorderLayer = layer;
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        self.bottomBorderLayer = layer;
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
        self.rightBorderLayer = layer;
    }
}

@end
