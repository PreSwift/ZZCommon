//
//  CommonWebShareBarView.h
//  jzjx
//
//  Created by westMac on 2022/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonWebShareBarView : UIView

@property(nonatomic, assign) CGFloat thisViewHeight;

@property(nonatomic, copy) void(^tapShareBtnBlock)(void);
@property(nonatomic, copy) void(^tapEmailBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
