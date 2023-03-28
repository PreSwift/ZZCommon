//
//  ZZThemeManager.h
//

#import <Foundation/Foundation.h>
#import "ZZThemeProtocol.h"

extern NSString * _Nullable const ZZSelectedThemeIdentifier;
extern NSString * _Nullable const ZZThemeIdentifierDefault;
extern NSString * _Nullable const ZZThemeIdentifierDark;

/// 简单对 QMUIThemeManager 做一层业务的封装，省去类型转换的工作量
@interface ZZThemeManager : NSObject

@property(class, nonatomic, readonly, nullable) NSObject<ZZThemeProtocol> *currentTheme;
@end

@interface UIColor (ZZTheme)

@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_backgroundColor;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_backgroundColorLighten;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_backgroundColorHighlighted;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_imageViewBackgroundColor;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_tintColor;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_auxiliaryColor1;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_auxiliaryColor2;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_auxiliaryColor3;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_titleTextColor;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_mainTextColor;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_descriptionTextColor;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_placeholderColor;
@property(class, nonatomic, strong, readonly) UIColor * _Nonnull qd_separatorColor;
@end

@interface UIImage (ZZTheme)

@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_navigationBarBackgroundImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_navigationBarBackIndicatorImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_navigationBarCloseImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_navigationBarDisclosureIndicatorImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_tableViewCellDisclosureIndicatorImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_tableViewCellCheckmarkImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_tableViewCellDetailButtonImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_searchBarTextFieldBackgroundImage;
@property(class, nonatomic, strong, readonly) UIImage * _Nonnull qd_searchBarBackgroundImage;
@end

@interface UIFont (ZZTheme)

@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_navigationBarTitleFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_titleFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_titleMediumFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_titleBoldFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_mainTextFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_mainTextMediumFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_mainTextBoldFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_descriptionTextFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_descriptionTextMediumFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_descriptionTextBoldFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_otherFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_otherMediumFont;
@property(class, nonatomic, strong, readonly) UIFont * _Nonnull qd_otherBoldFont;
@end

@interface UIVisualEffect (ZZTheme)

@property(class, nonatomic, strong, readonly) UIVisualEffect * _Nonnull qd_standardBlurEffect;
@end
