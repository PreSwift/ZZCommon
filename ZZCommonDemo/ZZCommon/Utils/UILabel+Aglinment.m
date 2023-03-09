//
//  UILabel+Aglinment.m
//  jzjx
//
//  Created by mac on 2022/3/18.
//

#import "UILabel+Aglinment.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Aglinment)

- (void)changeAlignmentRightAndLeft {
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.qmui_width, SCREEN_WIDTH) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil].size;
    CGFloat margin = (self.frame.size.width - textSize.width) / (self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributedString;
}

@end
