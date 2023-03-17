//
//  QDUIHelper.h
//

#import <Foundation/Foundation.h>
#import "ZZCommonMacros.h"

@interface QDUIHelper : NSObject

+ (void)renderGlobalAppearances;
@end


@interface QDUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance;
@end


@interface QDUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance;
@end

@interface QDUIHelper (QMUIDialogViewControllerAppearance)

+ (void)customDialogViewControllerAppearance;
@end


@interface QDUIHelper (QMUIEmotionView)

+ (void)customEmotionViewAppearance;
@end


@interface QDUIHelper (QMUIImagePicker)

+ (void)customImagePickerAppearance;
@end

@interface QDUIHelper (QMUIPopupContainerView)

+ (void)customPopupAppearance;
@end


@interface QDUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;
@end


@interface QDUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton;
+ (QMUIButton *)generateLightBorderedButton;
+ (QMUIButton *)generateGhostButtonWithColor:(UIColor *)color;
+ (QMUIButton *)generateGhostButton;

@end


@interface QDUIHelper (Emotion)

+ (NSArray<QMUIEmotion *> *)qmuiEmotions;

/// 用于主题更新后，更新表情 icon 的颜色
+ (void)updateEmotionImages;
@end


@interface QDUIHelper (SavePhoto)

+ (void)showAlertWhenSavedPhotoFailureByPermissionDenied;
@end


@interface QDUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size;
@end


@interface QDUIHelper (Theme)

+ (UIImage *)navigationBarBackgroundImageWithThemeColor:(UIColor *)color;
@end

@interface QDUIHelper (Layer)

+ (CALayer *)generateSeparatorLayer;
@end

@interface NSString (Code)

- (void)enumerateCodeStringUsingBlock:(void (^)(NSString *codeString, NSRange codeRange))block;
@end

