//
//  CheckRadioModel.m

//  Created by mac on 2022/2/8.
//

#import "CheckRadioModel.h"

@implementation CheckRadioModel

+ (instancetype)instanceWithName:(NSString *)name markImage:(UIImage *)markImage unMarkImage:(UIImage *)unMarkImage {
    return [CheckRadioModel instanceWithName:name markImage:markImage unMarkImage:unMarkImage showDesc:nil showInputView:NO];
}

+ (instancetype)instanceWithName:(NSString *)name markImage:(UIImage *)markImage unMarkImage:(UIImage *)unMarkImage showDesc:(NSString *)showDesc showInputView:(BOOL)showInputView {
    CheckRadioModel *model = [[CheckRadioModel alloc] init];
    model.name = name;
    model.markImage = markImage;
    model.unMarkImage = unMarkImage;
    model.showDesc = showDesc;
    model.showInputView = showInputView;
    return model;
}

@end
