//
//  QDNavigateHelper.h

//  Created by westMac on 2021/10/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QDNavigateHelper <NSObject>

+ (void)pushToVCWith:(NSString *)jumnData;

@end

@interface QDNavigateHelper : NSObject <QDNavigateHelper>

@end

NS_ASSUME_NONNULL_END
