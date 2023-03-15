//
//  SortButton.h
//  teacher
//
//  Created by mac on 2022/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SortButtonState) {
    SortButtonStateNoSort,
    SortButtonStateSortUp,
    SortButtonStateSortDown
};

@interface SortButton : UIControl

@property(nonatomic, strong, nullable) NSString *title;
@property(nonatomic, assign) SortButtonState sortState;
@property(nonatomic, copy) void(^sortChangeBlock)(SortButtonState sortState);

@end

NS_ASSUME_NONNULL_END
