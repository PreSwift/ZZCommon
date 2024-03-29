//
//  ZZRptSize.m

//  Created by west007 on 2021/7/7.
//

#import "ZZRptSize.h"
#import "ZZCommonMacros.h"

static CGFloat globalMuta = -1;

@implementation ZZRptSize

+ (CGFloat)pt2rpt:(NSNumber *)pt {
    if (globalMuta == -1) {
        CGFloat designWidth = DESIGN_WIDTH;
        CGFloat screenWidth = MIN(ScreenBoundsSize.width, ScreenBoundsSize.height);
        CGFloat muta = screenWidth / designWidth;
        muta = MAX(0.94, muta);
        muta = MIN(1.0, muta);
        globalMuta = muta;
    }
    return ceilf([pt qmui_CGFloatValue] * globalMuta);
}

@end
