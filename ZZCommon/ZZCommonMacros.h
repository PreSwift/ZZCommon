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
#define CodeAttributes(_fontSize) @{NSFontAttributeName: CodeFontMake(_fontSize), NSForegroundColorAttributeName: QDThemeManager.currentTheme.themeTintColor}\

/**
 间距规范，统一为8的倍数
 */
#define Spaceing(_times) SS((4.0 * _times))

/**
 圆角规范，通常为8，特例为4的倍数
 */
#define CornerRadius(_times) SS((4.0 * _times))
#define DefaultCornerRadius CornerRadius(2)

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

/**
 服务器指向配置
 */
#define CDN_HOST @"https://static.wtjy.com/"
#define BASE_WEB_HOST @"https://phone.wtjy.com/"
#ifdef DEBUG
//#define BASE_HOST @"https://erp.wtjy.com/"
#define BASE_HOST @"http://192.168.20.241:9999/"
#else
//#define BASE_HOST @"https://erp.wtjy.com/"
#define BASE_HOST @"http://192.168.20.241:9999/"
#endif

#define CREAT_URL(x) [[NSString alloc] initWithFormat:@"%@%@", BASE_HOST, x]
#define CREAT_WEB_URL(x) [[NSString alloc] initWithFormat:@"%@%@", BASE_WEB_HOST, x]
#define IsTestServer [BASE_HOST containsString:@"test"]
#define IsUITest NSProcessInfo.processInfo.environment[@"isUITest"].boolValue
#define COMMON_PAGE_SIZE 30
#ifdef DEBUG
#define SHOW_TEST YES
#else
#define SHOW_TEST NO
#endif

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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <QMUIKit/QMUIKit.h>
#import <PureLayout/PureLayout.h>
#import <SDWebImage/SDWebImage.h>
#import <MJExtension/MJExtension.h>
#import <DateTools/DateTools.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <YTKNetwork/YTKNetwork.h>
#import <Masonry/Masonry.h>

#import "QDThemeManager.h"
#import "QDUIHelper.h"
#import "QDNavigationController.h"
#import "QDNavigateHelper.h"
#import "QDCommonViewController.h"
#import "QDCommonTableViewController.h"
#import "QDRptSize.h"
#import "QDDialogHelper.h"
#import "ComApiHelper.h"
#import "ComApiHelper+FileUpload.h"
#import "ComApiHelper+Default.h"
#import "ComApiHelper+Batch.h"
#import "ComApiHelper+User.h"
#import "ComUserHelper.h"
#import "UILabel+Aglinment.h"
#import "QMUICommonViewController+Search.h"
#import "QMUICommonViewController+FixBackGesture.h"
#import "QMUICommonViewController+EmptyView.h"
#import "QMUICommonViewController+Alert.h"
#import "TimeUtil.h"
#import "HtmlUtil.h"
#import "NSStringUtil.h"
#import "ColorUtil.h"
#import "UIImage+Extension.h"
#import "UIView+EmptyView.h"
#import "UIView+SDExtension.h"
#import "UIView+Extension.h"
#import "NSBundle+Extension.h"
#import "QDImagePreviewViewController.h"
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "UIScrollView+RequestPageExtension.h"
#import "UIImageView+Extension.h"
#import "NSDictionary+Extension.h"
#import "DownPopupMenuButton.h"
#import "QDUITips.h"
#import "SMEnum.h"
#import "BRPickerView.h"

#endif
