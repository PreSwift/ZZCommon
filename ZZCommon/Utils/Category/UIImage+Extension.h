//
//  UIImage+Extension.h

//  Created by westMac on 2021/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

+ (NSString *)saveImageToLocal:(UIImage*)image keys:(NSString*)key;
+ (UIImage*)getImageFromLocal:(NSString*)key;
+ (BOOL)localHaveImage:(NSString*)key;
+ (void)removeImageToLocalKeys:(NSString*)key;

- (UIImage *)fixOrientation;

@end

NS_ASSUME_NONNULL_END
