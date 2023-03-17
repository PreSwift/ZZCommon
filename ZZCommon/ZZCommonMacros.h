//
//  ZZCommonPrefixHeader.pch
//  ZZCommonDemo
//
//  Created by mac on 2023/3/13.
//

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.

/**
 字体颜色相关
 */
#define CodeFontMake(_pointSize) [UIFont fontWithName:@"PingFangSC-Regular" size:_pointSize]
#define CodeMediumFontMake(_pointSize) [UIFont fontWithName:@"PingFangSC-Medium" size:_pointSize]
#define CodeBoldFontMake(_pointSize) [UIFont fontWithName:@"PingFangSC-Semibold" size:_pointSize]
#define CodeAttributes(_fontSize) @{NSFontAttributeName: CodeFontMake(_fontSize), NSForegroundColorAttributeName: ZZThemeManager.currentTheme.themeTintColor}\

/**
 间距规范，统一为4的倍数
 */
#define Spaceing(_times) SS((4.0 * _times))

/**
 圆角规范，统一为4的倍数
 */
#define CornerRadius(_times) SS((4.0 * _times))

/**
 阴影区规范
 */
#define DefaultShadowColor UIColorMakeWithHex(@"#E0E0E0")
#define DefaultShadowRadius 5
#define DefaultShadowOpacity 0.6
#define DefaultShadowOffset CGSizeZero

/**
 参照iPhone x尺寸
 */
#define DESIGN_WIDTH 375

/**
 适配宏
 */
#define SS(x) [QDRptSize pt2rpt:@x]

#define CREAT_URL(x) [[NSString alloc] initWithFormat:@"%@%@", BASE_HOST, x]
#define CREAT_WEB_URL(x) [[NSString alloc] initWithFormat:@"%@%@", BASE_WEB_HOST, x]
#define IsUITest NSProcessInfo.processInfo.environment[@"isUITest"].boolValue
#define COMMON_PAGE_SIZE 30

/**
 完美解决Xcode NSLog打印不全的宏
*/
#ifdef DEBUG
#define NSLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];\
[dateFormatter setTimeZone:timeZone];\
[dateFormatter setDateFormat:@"HH:mm:ss.SSSSSSZ"];\
NSString *str = [dateFormatter stringFromDate:[NSDate date]];\
fprintf(stderr,"******\nTIME：%s【FILE：%s--LINE：%d】FUNCTION：%s\n%s\n******\n",[str UTF8String],[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__PRETTY_FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}
#else
# define NSLog(...);
#endif

/**
 主线程执行block
 */
#ifndef DISPATCH_MAIN_SYNC_SAFE
#define DISPATCH_MAIN_SYNC_SAFE(block)              \
    if ([NSThread isMainThread]) {                       \
        block();                                         \
    } else {                                             \
        dispatch_sync(dispatch_get_main_queue(), block); \
    }
#endif


/**
 import
 */

#ifdef __OBJC__

// Base
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


// Pods
#import <QMUIKit/QMUIKit.h>
#import <PureLayout/PureLayout.h>
#import <SDWebImage/SDWebImage.h>
#import <MJExtension/MJExtension.h>
#import <DateTools/DateTools.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <YTKNetwork/YTKNetwork.h>
#import <Masonry/Masonry.h>

// Api
#import <ZZCommon/ZZApi.h>

// Utils
#import <ZZCommon/ZZUtils.h>

// Components
#import <ZZCommon/ZZComponents.h>

// Enum
#import <ZZCommon/ZZEnum.h>

// OtherLib
#import <ZZCommon/ZZOtherLib.h>

// UIMainFrame
#import <ZZCommon/ZZMainFrame.h>

// Theme
#import <ZZCommon/ZZTheme.h>

#endif

