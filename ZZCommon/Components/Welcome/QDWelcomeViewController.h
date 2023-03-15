//
//  QDWelcomeViewController.h
//  jzjx
//
//  Created by mac on 2022/6/21.
//

#import "QDCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDWelcomeViewController : QDCommonViewController

@property(nonatomic, copy) void(^changeVCToMainBlock)(void);

@end

NS_ASSUME_NONNULL_END
