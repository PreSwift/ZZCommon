//
//  ZZWelcomePageItem.m

//  Created by mac on 2022/6/21.
//

#import "ZZWelcomePageItem.h"

@implementation ZZWelcomePageItem

- (instancetype)initWithImageName:(NSString *)imageName text1:(NSString *)text1 text2:(NSString *)text2 {
    self = [super init];
    if (self) {
        _imageName = imageName;
        _text1 = text1;
        _text2 = text2;
    }
    return self;
}

@end
