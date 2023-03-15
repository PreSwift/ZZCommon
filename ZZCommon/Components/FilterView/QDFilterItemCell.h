//
//  QDFilterItemCell.h

//  Created by mac on 2022/8/10.
//

#import <UIKit/UIKit.h>
#import "QDFilterRow.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDFilterItemCell : UICollectionViewCell

- (void)updateWithTitle:(NSString *)title isSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
