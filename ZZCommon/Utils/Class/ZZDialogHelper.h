//
//  ZZDialogHelper.h

//  Created by west007 on 2021/7/13.
//

#import <Foundation/Foundation.h>
#import <QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZDialogHelper : NSObject

///提示类对话框，只有一个“我知道了”的确认按钮
+ (void)showAlertDialog:(NSString *)title
                content:(NSString *)content
                okBlock:(nullable void (^)(__kindof QMUIModalPresentationViewController *dialogViewController))block;

+ (void)showAlertDialog:(NSString *)title
                content:(NSString *)content
             okBtnTitle:(nullable NSString *)okBtnTitle
                okBlock:(nullable void (^)(__kindof QMUIModalPresentationViewController *dialogViewController))block;

///普通对话框，提供一个取消按钮，一个确认按钮
+ (void)showNormalDialog:(NSString *)title
                 content:(NSString *)content
             cancelBlock:(nullable void (^)(__kindof QMUIModalPresentationViewController *dialogViewController))cancelBlock
                 okBlock:(nullable void (^)(__kindof QMUIModalPresentationViewController *dialogViewController))okBlock;

+ (void)showNormalDialog:(NSString *)title
             description:(NSString *)desc
             cancelBlock:(nullable void (^)(__kindof QMUIDialogViewController * _Nonnull))cancelBlock
                 okBlock:(nullable void (^)(__kindof QMUIDialogViewController * _Nonnull))okBlock;

+ (void)showAlert2Dialog:(NSString *)title
             description:(NSString *)desc
                 okBlock:(nullable void (^)(__kindof QMUIModalPresentationViewController *dialogViewController))block;

+ (void)showVersionUpdateDialog:(NSString *)title
                    description:(NSString *)desc
                            url:(NSString *)url
                  isForceUpdate:(BOOL)isForceUpdate;

+ (void)showNoticeDialog:(NSString *)title
             description:(NSString *)desc;

+ (void)showBindTipsWithOkBlock:(nullable void (^)(__kindof QMUIModalPresentationViewController *dialogViewController))block;
@end

NS_ASSUME_NONNULL_END
