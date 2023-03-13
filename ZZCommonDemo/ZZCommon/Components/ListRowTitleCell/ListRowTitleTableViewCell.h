//
//  ListRowTitleTableViewCell.h
//  student
//
//  Created by westMac on 2021/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListRowTitleTableViewCell : UITableViewCell

- (void)updateTitle: (NSString *)title showAll: (BOOL)showAll;

@end

NS_ASSUME_NONNULL_END
