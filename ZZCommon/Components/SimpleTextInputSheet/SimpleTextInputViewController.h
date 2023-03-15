//
//  SimpleTextInputViewController.h

//  Created by westMac on 2021/8/30.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SimpleTextInputBlock) (NSString * _Nullable str);

@interface SimpleTextInputViewController : QMUIModalPresentationViewController

@property(nonatomic, copy) SimpleTextInputBlock callBack;

- (instancetype)initAlert;

@end

NS_ASSUME_NONNULL_END
