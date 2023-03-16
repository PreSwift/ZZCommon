//
//  ZZWelcomeViewController.h

//  Created by mac on 2022/6/21.
//

#import "ZZCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZWelcomeViewController : ZZCommonViewController

@property(nonatomic, copy) void(^changeVCToMainBlock)(void);

@end

NS_ASSUME_NONNULL_END
