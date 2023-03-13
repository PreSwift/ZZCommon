//
//  QDPasswordLoginViewController.h
//  jzjx
//
//  Created by mac on 2022/8/24.
//

#import "QDBaseLoginViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDPasswordLoginViewController : QDBaseLoginViewController<QMUITextFieldDelegate>

@property(nonatomic, strong) NSString *initialUserName;

@end

NS_ASSUME_NONNULL_END
