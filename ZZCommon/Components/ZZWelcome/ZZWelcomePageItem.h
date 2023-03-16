//
//  ZZWelcomePageItem.h

//  Created by mac on 2022/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZWelcomePageItem : NSObject

@property(nonatomic, strong) NSString *imageName;
@property(nonatomic, strong) NSString *text1;
@property(nonatomic, strong) NSString *text2;

- (instancetype)initWithImageName:(NSString *)imageName text1:(NSString *)text1 text2:(NSString *)text2;

@end

NS_ASSUME_NONNULL_END
