//
//  UIImageView+Extension.m

//  Created by westMac on 2021/11/4.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

//- (UIImage *)captureImage {
//    if (self.image == nil) {
//        return nil;
//    }
//    CGSize selfSize = self.mj_size;
//    UIImage *image = self.image;
//    CGSize imagesize = image.size;
//    CGFloat scaleWith = imagesize.width / selfSize.width;
//    CGFloat scaleHeight = imagesize.height / selfSize.height;
//    NSArray<UIView *> *subviews = self.subviews;
//    for (int i=0; i<subviews.count;i++) {
//        UIView *subview = subviews[i];
//        CGSize subsize = subview.mj_size;
//        CGPoint sublocation = subview.mj_origin;
//        CGSize tosize = CGSizeMake(subsize.width * scaleWith, subsize.height * scaleHeight);
//        UIImage *subimage = [[subview qmui_snapshotLayerImage] qmui_imageResizedInLimitedSize:tosize resizingMode:QMUIImageResizingModeScaleAspectFit scale:MAX(scaleWith, scaleHeight)];
//        CGPoint topoint = CGPointMake(sublocation.x * scaleWith, sublocation.y * scaleHeight);
//        image = [image qmui_imageWithImageAbove:subimage atPoint:topoint];
//    }
//    return image;
//}

@end
