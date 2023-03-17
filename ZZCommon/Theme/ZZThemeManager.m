//
//  ZZThemeManager.m
//

#import "ZZThemeManager.h"
#import "ZZCommonMacros.h"

NSString *const QDSelectedThemeIdentifier = @"selectedThemeIdentifier";
NSString *const QDThemeIdentifierDefault = @"Default";
NSString *const QDThemeIdentifierDark = @"Dark";

@interface ZZThemeManager ()

@property(nonatomic, strong) UIColor *qd_backgroundColor;
@property(nonatomic, strong) UIColor *qd_backgroundColorLighten;
@property(nonatomic, strong) UIColor *qd_backgroundColorHighlighted;
@property(nonatomic, strong) UIColor *qd_imageViewBackgroundColor;
@property(nonatomic, strong) UIColor *qd_tintColor;
@property(nonatomic, strong) UIColor *qd_auxiliaryColor1;
@property(nonatomic, strong) UIColor *qd_auxiliaryColor2;
@property(nonatomic, strong) UIColor *qd_auxiliaryColor3;
@property(nonatomic, strong) UIColor *qd_titleTextColor;
@property(nonatomic, strong) UIColor *qd_mainTextColor;
@property(nonatomic, strong) UIColor *qd_descriptionTextColor;
@property(nonatomic, strong) UIColor *qd_placeholderColor;
@property(nonatomic, strong) UIColor *qd_separatorColor;

@property(nonatomic, strong) UIImage *qd_navigationBarBackgroundImage;
@property(nonatomic, strong) UIImage *qd_navigationBarBackIndicatorImage;
@property(nonatomic, strong) UIImage *qd_navigationBarCloseImage;
@property(nonatomic, strong) UIImage *qd_navigationBarDisclosureIndicatorImage;
@property(nonatomic, strong) UIImage *qd_tableViewCellDisclosureIndicatorImage;
@property(nonatomic, strong) UIImage *qd_tableViewCellCheckmarkImage;
@property(nonatomic, strong) UIImage *qd_tableViewCellDetailButtonImage;
@property(nonatomic, strong) UIImage *qd_searchBarTextFieldBackgroundImage;
@property(nonatomic, strong) UIImage *qd_searchBarBackgroundImage;

@property(nonatomic, strong) UIFont *qd_navigationBarTitleFont; //导航栏标题字体
@property(nonatomic, strong) UIFont *qd_titleFont; //标题字体
@property(nonatomic, strong) UIFont *qd_titleMediumFont; //标题字体
@property(nonatomic, strong) UIFont *qd_titleBoldFont; //标题字体
@property(nonatomic, strong) UIFont *qd_mainTextFont; //正文字体
@property(nonatomic, strong) UIFont *qd_mainTextMediumFont; //正文字体
@property(nonatomic, strong) UIFont *qd_mainTextBoldFont; //正文字体
@property(nonatomic, strong) UIFont *qd_descriptionTextFont; //注释字体
@property(nonatomic, strong) UIFont *qd_descriptionTextMediumFont; //注释字体
@property(nonatomic, strong) UIFont *qd_descriptionTextBoldFont; //注释字体
@property(nonatomic, strong) UIFont *qd_otherFont; //特例情况字体
@property(nonatomic, strong) UIFont *qd_otherMediumFont; //特例情况字体
@property(nonatomic, strong) UIFont *qd_otherBoldFont; //特例情况字体

@property(nonatomic, strong) UIVisualEffect *qd_standardBlueEffect;

@property(class, nonatomic, strong, readonly) ZZThemeManager *sharedInstance;
@end

@implementation ZZThemeManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ZZThemeManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (instancetype)init {
    if (self = [super init]) {
        self.qd_backgroundColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeBackgroundColor;
        }];
        self.qd_backgroundColorLighten = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<ZZThemeProtocol> * _Nullable theme) {
            return theme.themeBackgroundColorLighten;
        }];
        self.qd_backgroundColorHighlighted = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeBackgroundColorHighlighted;
        }];
        self.qd_imageViewBackgroundColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeImageViewBackgroundColor;
        }];
        self.qd_tintColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeTintColor;
        }];
        self.qd_auxiliaryColor1 = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeAuxiliaryColor1;
        }];
        self.qd_auxiliaryColor2 = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeAuxiliaryColor2;
        }];
        self.qd_auxiliaryColor3 = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeAuxiliaryColor3;
        }];
        self.qd_titleTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeTitleTextColor;
        }];
        self.qd_mainTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeMainTextColor;
        }];
        self.qd_descriptionTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeDescriptionTextColor;
        }];
        self.qd_placeholderColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themePlaceholderColor;
        }];
        self.qd_separatorColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> *theme) {
            return theme.themeSeparatorColor;
        }];
        
        self.qd_navigationBarBackgroundImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<ZZThemeProtocol> * _Nullable theme) {
            return [UIImage qmui_imageWithColor:theme.themeTintColor];
        }];
        self.qd_navigationBarBackIndicatorImage = [UIImage qmui_imageWithShape:QMUIImageShapeNavBack size:CGSizeMake(12, 20) tintColor:UIColor.whiteColor];
        self.qd_navigationBarCloseImage = [UIImage qmui_imageWithShape:QMUIImageShapeNavClose size:CGSizeMake(16, 16) tintColor:UIColor.whiteColor];
        self.qd_navigationBarDisclosureIndicatorImage = [[UIImage qmui_imageWithShape:QMUIImageShapeTriangle size:CGSizeMake(8, 5) tintColor:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.qd_tableViewCellDisclosureIndicatorImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<ZZThemeProtocol> * _Nullable theme) {
            return [identifier isEqualToString:QDThemeIdentifierDark] ? [UIImage qmui_imageWithShape:QMUIImageShapeDisclosureIndicator size:CGSizeMake(6, 10) lineWidth:1 tintColor:UIColorMake(98, 100, 104)] : [UIImage qmui_imageWithShape:QMUIImageShapeDisclosureIndicator size:CGSizeMake(6, 10) lineWidth:1 tintColor:QMUICMI.grayLightenColor];
        }];
        self.qd_tableViewCellCheckmarkImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<ZZThemeProtocol> * _Nullable theme) {
            return [UIImage qmui_imageWithShape:QMUIImageShapeCheckmark size:CGSizeMake(15, 12) tintColor:self.qd_tintColor];
        }];
        self.qd_tableViewCellDetailButtonImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<ZZThemeProtocol> * _Nullable theme) {
            return [UIImage qmui_imageWithShape:QMUIImageShapeDetailButtonImage size:CGSizeMake(20, 20) tintColor:self.qd_tintColor];
        }];
        self.qd_searchBarTextFieldBackgroundImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<ZZThemeProtocol> * _Nullable theme) {
            return [UISearchBar qmui_generateTextFieldBackgroundImageWithColor:theme.themeBackgroundColorHighlighted];
        }];
        self.qd_searchBarBackgroundImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<ZZThemeProtocol> * _Nullable theme) {
            return [UISearchBar qmui_generateBackgroundImageWithColor:theme.themeBackgroundColor borderColor:nil];
        }];
        
        self.qd_standardBlueEffect = [UIVisualEffect qmui_effectWithThemeProvider:^UIVisualEffect * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<ZZThemeProtocol> * _Nullable theme) {
            return [UIBlurEffect effectWithStyle:[identifier isEqualToString:QDThemeIdentifierDark] ? UIBlurEffectStyleDark : UIBlurEffectStyleLight];
        }];
        
        self.qd_navigationBarTitleFont = CodeMediumFontMake(SS(18));
        self.qd_titleFont = CodeFontMake(SS(16));
        self.qd_titleMediumFont = CodeMediumFontMake(SS(16));
        self.qd_titleBoldFont = CodeBoldFontMake(SS(16));
        self.qd_mainTextFont = CodeFontMake(SS(14));
        self.qd_mainTextMediumFont = CodeMediumFontMake(SS(14));
        self.qd_mainTextBoldFont = CodeBoldFontMake(SS(14));
        self.qd_descriptionTextFont = CodeFontMake(SS(12));
        self.qd_descriptionTextMediumFont = CodeMediumFontMake(SS(12));
        self.qd_descriptionTextBoldFont = CodeBoldFontMake(SS(12));
        self.qd_otherFont = CodeFontMake(SS(11));
        self.qd_otherMediumFont = CodeMediumFontMake(SS(11));
        self.qd_otherBoldFont = CodeBoldFontMake(SS(11));
    }
    return self;
}

+ (NSObject<ZZThemeProtocol> *)currentTheme {
    return QMUIThemeManagerCenter.defaultThemeManager.currentTheme;
}

@end

@implementation UIColor (QDTheme)

+ (instancetype)qd_sharedInstance {
    static dispatch_once_t onceToken;
    static UIColor *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (UIColor *)qd_backgroundColor {
    return ZZThemeManager.sharedInstance.qd_backgroundColor;
}

+ (UIColor *)qd_backgroundColorLighten {
    return ZZThemeManager.sharedInstance.qd_backgroundColorLighten;
}

+ (UIColor *)qd_backgroundColorHighlighted {
    return ZZThemeManager.sharedInstance.qd_backgroundColorHighlighted;
}

+ (UIColor *)qd_imageViewBackgroundColor {
    return ZZThemeManager.sharedInstance.qd_imageViewBackgroundColor;
}

+ (UIColor *)qd_tintColor {
    return ZZThemeManager.sharedInstance.qd_tintColor;
}

+ (UIColor *)qd_auxiliaryColor1 {
    return ZZThemeManager.sharedInstance.qd_auxiliaryColor1;
}

+ (UIColor *)qd_auxiliaryColor2 {
    return ZZThemeManager.sharedInstance.qd_auxiliaryColor2;
}

+ (UIColor *)qd_auxiliaryColor3 {
    return ZZThemeManager.sharedInstance.qd_auxiliaryColor3;
}

+ (UIColor *)qd_titleTextColor {
    return ZZThemeManager.sharedInstance.qd_titleTextColor;
}

+ (UIColor *)qd_mainTextColor {
    return ZZThemeManager.sharedInstance.qd_mainTextColor;
}

+ (UIColor *)qd_descriptionTextColor {
    return ZZThemeManager.sharedInstance.qd_descriptionTextColor;
}

+ (UIColor *)qd_placeholderColor {
    return ZZThemeManager.sharedInstance.qd_placeholderColor;
}

+ (UIColor *)qd_separatorColor {
    return ZZThemeManager.sharedInstance.qd_separatorColor;
}

@end

@implementation UIImage (QDTheme)

+ (UIImage *)qd_navigationBarBackgroundImage {
    return ZZThemeManager.sharedInstance.qd_navigationBarBackgroundImage;
}

+ (UIImage *)qd_navigationBarBackIndicatorImage {
    return ZZThemeManager.sharedInstance.qd_navigationBarBackIndicatorImage;
}

+ (UIImage *)qd_navigationBarCloseImage {
    return ZZThemeManager.sharedInstance.qd_navigationBarCloseImage;
}

+ (UIImage *)qd_navigationBarDisclosureIndicatorImage {
    return ZZThemeManager.sharedInstance.qd_navigationBarDisclosureIndicatorImage;
}

+ (UIImage *)qd_tableViewCellDisclosureIndicatorImage {
    return ZZThemeManager.sharedInstance.qd_tableViewCellDisclosureIndicatorImage;
}

+ (UIImage *)qd_tableViewCellCheckmarkImage {
    return ZZThemeManager.sharedInstance.qd_tableViewCellCheckmarkImage;
}

+ (UIImage *)qd_tableViewCellDetailButtonImage {
    return ZZThemeManager.sharedInstance.qd_tableViewCellDetailButtonImage;
}

+ (UIImage *)qd_searchBarTextFieldBackgroundImage {
    return ZZThemeManager.sharedInstance.qd_searchBarTextFieldBackgroundImage;
}

+ (UIImage *)qd_searchBarBackgroundImage {
    return ZZThemeManager.sharedInstance.qd_searchBarBackgroundImage;
}

@end

@implementation UIVisualEffect (QDTheme)

+ (UIVisualEffect *)qd_standardBlurEffect {
    return ZZThemeManager.sharedInstance.qd_standardBlueEffect;
}

@end

@implementation UIFont (QDTheme)

+ (UIFont *)qd_navigationBarTitleFont {
    return ZZThemeManager.sharedInstance.qd_navigationBarTitleFont;
}

+ (UIFont *)qd_titleFont {
    return ZZThemeManager.sharedInstance.qd_titleFont;
}

+ (UIFont *)qd_titleMediumFont {
    return ZZThemeManager.sharedInstance.qd_titleMediumFont;
}

+ (UIFont *)qd_titleBoldFont {
    return ZZThemeManager.sharedInstance.qd_titleBoldFont;
}

+ (UIFont *)qd_mainTextFont {
    return ZZThemeManager.sharedInstance.qd_mainTextFont;
}

+ (UIFont *)qd_mainTextMediumFont {
    return ZZThemeManager.sharedInstance.qd_mainTextMediumFont;
}

+ (UIFont *)qd_mainTextBoldFont {
    return ZZThemeManager.sharedInstance.qd_mainTextBoldFont;
}

+ (UIFont *)qd_descriptionTextFont {
    return ZZThemeManager.sharedInstance.qd_descriptionTextFont;
}

+ (UIFont *)qd_descriptionTextMediumFont {
    return ZZThemeManager.sharedInstance.qd_descriptionTextMediumFont;
}

+ (UIFont *)qd_descriptionTextBoldFont {
    return ZZThemeManager.sharedInstance.qd_descriptionTextBoldFont;
}

+ (UIFont *)qd_otherFont {
    return ZZThemeManager.sharedInstance.qd_otherFont;
}

+ (UIFont *)qd_otherMediumFont {
    return ZZThemeManager.sharedInstance.qd_otherMediumFont;
}

+ (UIFont *)qd_otherBoldFont {
    return ZZThemeManager.sharedInstance.qd_otherBoldFont;
}

@end
