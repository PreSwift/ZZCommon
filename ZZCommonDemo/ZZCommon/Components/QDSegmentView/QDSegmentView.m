//
//  QDSegmentView.m
//  jzjx
//
//  Created by westMac on 2021/8/3.
//

#import "QDSegmentView.h"

@interface QDSegmentView ()

@property(nonatomic, strong) NSArray<QMUIButton *> *btns;
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, assign) int selectIndex;
@property(nonatomic, copy) void (^tapBlock)(int);

@end

@implementation QDSegmentView

- (void)dealloc
{
    NSLog(@"%@", [self class]);
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles tapBlock:(nonnull void (^)(int))tapBlock {
    self = [super init];
    if (self) {
        self.selectIndex = 0;
        self.tapBlock = tapBlock;
        self.titles = titles;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    NSMutableArray *tempBtns = [NSMutableArray arrayWithCapacity:_titles.count];
    for (int i=0;i<_titles.count;i++){
        QMUIButton *btn = [[QMUIButton alloc] initForAutoLayout];
        btn.contentEdgeInsets = UIEdgeInsetsMake(SS(5), 0, SS(5), 0);
        btn.tag = i;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = CodeFontMake(SS(14));
        btn.qmui_borderPosition = QMUIViewBorderPositionBottom;
        btn.qmui_borderColor = UIColor.qd_tintColor;
        if (_selectIndex == i) {
            btn.qmui_borderWidth = 2;
        } else {
            btn.qmui_borderWidth = 0;
        }
        [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [tempBtns addObject:btn];
        [self addSubview:btn];
        
        // autoLayout
        if (i==0) {
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            [btn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SS(20)];
        } else {
            [btn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:tempBtns[i-1]];
            [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tempBtns[i-1] withOffset:SS(30)];
        }
        if (i==_titles.count-1){
            [btn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:SS(20) relation:NSLayoutRelationGreaterThanOrEqual];
        }
    }
    
    self.btns = tempBtns;
}

- (void)tapBtn: (QMUIButton *)sender {
    if (_selectIndex != sender.tag) {
        self.btns[_selectIndex].qmui_borderWidth = 0;
        self.selectIndex = (int)sender.tag;
        sender.qmui_borderWidth = 2;
        if (self.tapBlock) {
            self.tapBlock(self.selectIndex);
        }
    }
}

@end
