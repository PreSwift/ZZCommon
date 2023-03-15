//
//  ZZFilterItemCell.h

//  Created by mac on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "ZZFilterRow.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZFilterItemCell : UICollectionViewCell

- (void)updateWithTitle:(NSString *)title isSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
