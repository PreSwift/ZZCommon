//
//  MyClassHeaderView.h
//  teacher
//
//  Created by westMac on 2021/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SegmentHeaderViewDelegate <NSObject>

- (void)selectSegmentIndex: (int)index;

@end

@interface SegmentHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles selectedIndex: (int)selectedIndex;

@property(nonatomic, weak) id<SegmentHeaderViewDelegate> delegate;

- (void)changeIndex: (int)index;

@end

NS_ASSUME_NONNULL_END
