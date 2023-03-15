//
//  GridImageView.m
//  teacher
//
//  Created by westMac on 2021/9/7.
//

#import "GridImageView.h"

@interface GridImageView ()



@end

@implementation GridImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor qd_imageViewBackgroundColor];
        self.layer.cornerRadius = CornerRadius(2);
        self.layer.masksToBounds = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initForAutoLayout];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        [imageView autoPinEdgesToSuperviewEdges];
        self.imageView = imageView;
        
        UIButton *button = [[UIButton alloc] initForAutoLayout];
        button.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        button.qmui_outsideEdge = UIEdgeInsetsMake(-20, -20, -20, -20);
        [button setImage:[[UIImage imageNamed:@"关闭白色叉"] qmui_imageWithSpacingExtensionInsets:UIEdgeInsetsMake(SS(5), SS(5), SS(5), SS(5))] forState:UIControlStateNormal];
        __weak __typeof(self)weakSelf = self;
        button.qmui_tapBlock = ^(__kindof UIControl *sender) {
            if (weakSelf.deleteBlock) {
                weakSelf.deleteBlock(weakSelf);
            }
        };
        [self addSubview:button];
        [button autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [button autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [button autoSetDimensionsToSize:CGSizeMake(SS(16), SS(16))];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (UIImage *)image {
    return self.imageView.image;
}

@end
