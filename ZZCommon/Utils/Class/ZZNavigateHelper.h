//
//  ZZNavigateHelper.h

//  Created by westMac on 2021/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZZNavigateHelper <NSObject>

+ (void)pushToVCWith:(NSString *)jumnData;

@end

@interface ZZNavigateHelper : NSObject <ZZNavigateHelper>

@end

NS_ASSUME_NONNULL_END
