//
//  MyClassHeaderView.m

//  Created by westMac on 2021/8/16.
//

#import "SegmentHeaderView.h"
#import "ZZCommonMacros.h"

@interface SegmentHeaderView()

@property(nonatomic, strong) NSArray<QMUIButton *> *btns;

@property(nonatomic, assign) int selectedIndex;

@property(nonatomic, strong) NSArray<NSString *> *titles;

@end

@implementation SegmentHeaderView

- (instancetype)initWithFrame:(CGRect)frame titles:(nonnull NSArray<NSString *> *)titles selectedIndex:(int)selectedIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        self.titles = titles;
        self.selectedIndex = selectedIndex;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    UIView *backView = [[UIView alloc] initForAutoLayout];
    [self addSubview:backView];
    [backView autoCenterInSuperview];
    
    NSMutableArray *btns = [NSMutableArray arrayWithCapacity:_titles.count];
    for (int i=0;i<_titles.count;i++) {
        QMUIButton *btn = [[QMUIButton alloc] initForAutoLayout];
        if (_selectedIndex == i) {
            btn.backgroundColor = UIColor.qd_tintColor;
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        } else {
            btn.backgroundColor = UIColor.whiteColor;
            [btn setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
        }
        btn.titleLabel.font = CodeFontMake(SS(14));
        btn.contentEdgeInsets = UIEdgeInsetsMake(SS(6), SS(12), SS(6), SS(12));
        btn.tag = i;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btn.cornerRadius = SS(4);
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        [btns addObject:btn];
        
        if (i==0) {
            [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [btn autoPinEdgesToSuperviewEdgesWithInsets: UIEdgeInsetsZero excludingEdge:ALEdgeRight];
        } else {
            [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:btns[i-1] withOffset:SS(20)];
            [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:btns[i-1]];
            [btn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:btns[i-1]];
        }
        if (i==_titles.count - 1) {
            [btn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        }
    }
    _btns = btns;
    
}

- (void)tapAction: (QMUIButton *)sender {
    if (_selectedIndex != sender.tag) {
        _btns[_selectedIndex].backgroundColor = UIColor.whiteColor;
        [_btns[_selectedIndex] setTitleColor:UIColor.qd_titleTextColor forState:UIControlStateNormal];
        sender.backgroundColor = UIColor.qd_tintColor;
        [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        if (self.delegate) {
            [self.delegate selectSegmentIndex:(int)sender.tag];
        }
        _selectedIndex = (int)sender.tag;
    }
}

- (void)changeIndex:(int)index {
    [self tapAction:_btns[index]];
}

@end
