//
//  CountdownViewController.h

//  Created by westMac on 2021/8/31.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CountDownCallBack) (void);

@interface CountdownViewController : UIView


- (instancetype)initWithCountDown: (int)seconds callback: (CountDownCallBack)callback;
- (void)show;

@end

NS_ASSUME_NONNULL_END
