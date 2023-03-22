//
//  ZZUIHelper.h
//

#import <Foundation/Foundation.h>
#import "ZZCommonMacros.h"

@interface ZZUIHelper : NSObject

+ (void)renderGlobalAppearances;
@end


@interface ZZUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance;
@end


@interface ZZUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance;
@end

@interface ZZUIHelper (QMUIDialogViewControllerAppearance)

+ (void)customDialogViewControllerAppearance;
@end


@interface ZZUIHelper (QMUIEmotionView)

+ (void)customEmotionViewAppearance;
@end


@interface ZZUIHelper (QMUIImagePicker)

+ (void)customImagePickerAppearance;
@end

@interface ZZUIHelper (QMUIPopupContainerView)

+ (void)customPopupAppearance;
@end


@interface ZZUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;
@end


@interface ZZUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton;
+ (QMUIButton *)generateLightBorderedButton;
+ (QMUIButton *)generateGhostButtonWithColor:(UIColor *)color;
+ (QMUIButton *)generateGhostButton;

@end


@interface ZZUIHelper (Emotion)

+ (NSArray<QMUIEmotion *> *)qmuiEmotions;

/// 用于主题更新后，更新表情 icon 的颜色
+ (void)updateEmotionImages;
@end


@interface ZZUIHelper (SavePhoto)

+ (void)showAlertWhenSavedPhotoFailureByPermissionDenied;
@end


@interface ZZUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size;
@end


@interface ZZUIHelper (Theme)

+ (UIImage *)navigationBarBackgroundImageWithThemeColor:(UIColor *)color;
@end

@interface ZZUIHelper (Layer)

+ (CALayer *)generateSeparatorLayer;
@end

@interface NSString (Code)

- (void)enumerateCodeStringUsingBlock:(void (^)(NSString *codeString, NSRange codeRange))block;
@end

