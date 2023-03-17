//
//  ZZFormItemModel.m

//  Created by Ethan on 2022/9/28.
//

#import "ZZFormItemModel.h"
#import "ZZCommonMacros.h"

@implementation ZZFormItemModel

- (instancetype)init {
    self = [self init];
    if (self) {
        NSAssert(0, @"请使用初始化方法initWithContent:accessoryImage:");
    }
    return self;
}

- (instancetype)initWithContent:(NSString *)content accessoryImage:(UIImage *)accessoryImage itemWidth:(CGFloat)itemWidth {
    self = [super init];
    if (self) {
        _content = content;
        _accessoryImage = accessoryImage;
        _itemWidth = itemWidth;
        [self initialValue];
    }
    return self;
}

- (void)initialValue {
    _numberOfLines = 0;
    _textAlignment = NSTextAlignmentCenter;
    _contentPadding = UIEdgeInsetsMake(SS(4), SS(4), SS(4), SS(4));
    _textFont = UIFont.qd_descriptionTextFont;
    _textColor = UIColor.qd_mainTextColor;
    _backgroundColor = UIColor.whiteColor;
    _accessoryImagePosition = QMUIButtonImagePositionLeft;
    _spacingBetweenAccessoryImageAndContent = SS(5);
    
    [self caculateHeight];
}

- (void)setNumberOfLines:(BOOL)numberOfLines {
    _numberOfLines = numberOfLines;
    [self caculateHeight];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    [self caculateHeight];
}

- (void)setContentPadding:(UIEdgeInsets)contentPadding {
    _contentPadding = contentPadding;
    [self caculateHeight];
}

- (void)caculateHeight {
    _itemHeight = SS(32);
    if (_content && _numberOfLines != 1) {
        CGFloat maxWidth = _itemWidth - _contentPadding.left - _contentPadding.right;
        if (_accessoryImage && (_accessoryImagePosition == QMUIButtonImagePositionLeft || _accessoryImagePosition == QMUIButtonImagePositionRight)) {
            maxWidth = maxWidth - _spacingBetweenAccessoryImageAndContent - _accessoryImage.size.width;
        }
        CGRect contentRect = [_content boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _textFont} context:nil];
        if (_accessoryImage) {
            if (_accessoryImagePosition == QMUIButtonImagePositionTop || _accessoryImagePosition == QMUIButtonImagePositionBottom) {
                _itemHeight = ceil(contentRect.size.height + _contentPadding.top + _contentPadding.bottom + _spacingBetweenAccessoryImageAndContent + _accessoryImage.size.height);
            } else {
                _itemHeight = ceil(MAX(contentRect.size.height + _contentPadding.top + _contentPadding.bottom, _accessoryImage.size.height + _contentPadding.top + _contentPadding.bottom));
            }
        } else {
            _itemHeight = ceil(contentRect.size.height + _contentPadding.top + _contentPadding.bottom);
        }
        _itemHeight = MAX(SS(32), _itemHeight);
    }
}

@end
