//
//  CheckRadioModel.m

//  Created by mac on 2022/2/8.
//

#import "CheckRadioModel.h"

@implementation CheckRadioModel

+ (instancetype)instanceWithName:(NSString *)name markImage:(UIImage *)markImage unMarkImage:(UIImage *)unMarkImage isSelected:(BOOL)isSelected {
    return [CheckRadioModel instanceWithName:name markImage:markImage unMarkImage:unMarkImage isSelected:isSelected showDesc:nil showInputView:NO];
}

+ (instancetype)instanceWithName:(NSString *)name markImage:(UIImage *)markImage unMarkImage:(UIImage *)unMarkImage isSelected:(BOOL)isSelected showDesc:(NSString *)showDesc showInputView:(BOOL)showInputView {
    CheckRadioModel *model = [[CheckRadioModel alloc] init];
    model.name = name;
    model.markImage = markImage;
    model.unMarkImage = unMarkImage;
    model.showDesc = showDesc;
    model.showInputView = showInputView;
    model.isSelected = isSelected;
    return model;
}
@end
