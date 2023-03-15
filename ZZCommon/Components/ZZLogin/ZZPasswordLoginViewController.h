//
//  ZZPasswordLoginViewController.h

//  Created by mac on 2022/8/24.
//

#import "ZZBaseLoginViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZPasswordLoginViewController : ZZBaseLoginViewController<QMUITextFieldDelegate>

@property(nonatomic, strong) NSString *initialUserName;

@end

NS_ASSUME_NONNULL_END
