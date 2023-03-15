//
//  GridImageView.h

//  Created by westMac on 2021/9/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GridImageViewBlock) (UIView *sender);

@interface GridImageView : UIControl

@property(nonatomic, copy) GridImageViewBlock deleteBlock;

@property(nonatomic, strong, nullable) UIImage *image;
@property(nonatomic, strong) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
