//
//  ZZNumberInputView.h

//  Created by westMac on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZNumberInputView : UIView

@property(nonatomic, strong) NSString *text;
@property(nonatomic, copy) void(^editChangedBlock)(NSString *numberStr);

@end

NS_ASSUME_NONNULL_END
