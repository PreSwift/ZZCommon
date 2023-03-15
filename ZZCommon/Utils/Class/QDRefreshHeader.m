//
//  QDRefreshHeader.m

//  Created by mac on 2022/7/12.
//

#import "QDRefreshHeader.h"

@implementation QDRefreshHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stateLabel.font = UIFont.qd_mainTextFont;
        self.stateLabel.textColor = UIColor.qd_descriptionTextColor;
        self.lastUpdatedTimeLabel.hidden = YES;
    }
    return self;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    self.arrowView.qmui_size = CGSizeMake(SS(12), SS(32));
    self.arrowView.center = CGPointMake(self.arrowView.center.x, self.qmui_height / 2);
}

@end
