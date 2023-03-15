//
//  UIImage+Extension.m

//  Created by westMac on 2021/10/14.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (NSString *)saveImageToLocal:(UIImage*)image keys:(NSString*)key {
    //首先,需要获取沙盒路径
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),key];
    NSLog(@"将图片保存到本地  %@",picPath);
    BOOL isHaveImage = [self localHaveImage:key];
    if (isHaveImage) {
        NSLog(@"本地已经保存该图片、无需再次存储...");
        return picPath;
    }
    NSData *imgData = UIImageJPEGRepresentation(image,0.5);
    [imgData writeToFile:picPath atomically:YES];
    return picPath;
}

//从本地获取图片
+ (UIImage*)getImageFromLocal:(NSString*)key {
    if (!key || [key isEqualToString:@""]) {
        return nil;
    }
    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),key];
    NSLog(@"获取图片   %@",picPath);
    UIImage *img = [[UIImage alloc]initWithContentsOfFile:picPath];
    return img;
}

//本地是否有图片
+ (BOOL)localHaveImage:(NSString*)key {
    if (!key || [key isEqualToString:@""]) {
        return NO;
    }
    //读取本地图片非resource
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),key];
    NSLog(@"查询是否存在 %@",picPath);
    UIImage *img = [[UIImage alloc]initWithContentsOfFile:picPath];
    if (img) {
        return YES;
    }
    return NO;
}

//将图片从本地删除
+ (void)removeImageToLocalKeys:(NSString*)key {
    NSString *picPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),key];
    NSLog(@"将图片从本地删除  %@", picPath);
    [[NSFileManager defaultManager] removeItemAtPath:picPath error:nil];

}

- (UIImage *)fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
