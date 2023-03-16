//
//  ZZSegmentView.h

//  Created by westMac on 2021/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZSegmentView : UIView

- (instancetype)initWithTitles: (NSArray<NSString *> *)titles tapBlock: (void (^)(int))tapBlock;

@end

NS_ASSUME_NONNULL_END
