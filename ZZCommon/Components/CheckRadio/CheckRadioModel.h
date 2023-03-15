//
//  CheckRadioModel.h
//  jzjx
//
//  Created by mac on 2022/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckRadioModel : NSObject

@property(nonatomic, assign) BOOL isSelected;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) BOOL showInputView;
@property(nonatomic, copy) NSString *showDesc;

@end

NS_ASSUME_NONNULL_END
