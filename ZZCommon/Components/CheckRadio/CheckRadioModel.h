//
//  CheckRadioModel.h

//  Created by mac on 2022/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckRadioModel : NSObject

@property(nonatomic, assign) BOOL isSelected;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) UIImage *markImage;
@property(nonatomic, strong) UIImage *unMarkImage;
@property(nonatomic, assign) BOOL showInputView;
@property(nonatomic, copy) NSString *showDesc;

+ (instancetype)instanceWithName:(NSString *)name markImage:(UIImage *)markImage unMarkImage:(UIImage *)unMarkImage isSelected:(BOOL)isSelected;

+ (instancetype)instanceWithName:(NSString *)name markImage:(UIImage *)markImage unMarkImage:(UIImage *)unMarkImage isSelected:(BOOL)isSelected showDesc:(nullable NSString *)showDesc showInputView:(BOOL)showInputView;

@end

NS_ASSUME_NONNULL_END
