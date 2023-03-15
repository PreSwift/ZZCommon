//
//  ProtocolAndPrivacyView.h

//  Created by mac on 2022/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtocolAndPrivacyView : UIView

@property(nonatomic, assign) BOOL isCheck;
@property(nonatomic, copy) void(^checkChangeBlock)(void);

- (void)showActionSheet;

@end

NS_ASSUME_NONNULL_END
