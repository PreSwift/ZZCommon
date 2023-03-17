//
//  CountdownViewController.m

//  Created by westMac on 2021/8/31.
//

#import "CountdownViewController.h"
#import "ZZCommonMacros.h"

@interface CountdownViewController ()

@property(nonatomic, assign) int seconds;
@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) CountDownCallBack callback;

@end

@implementation CountdownViewController

- (void)dealloc
{
    [self.timer invalidate];
}

- (instancetype)initWithCountDown:(int)seconds callback:(nonnull CountDownCallBack)callback {
    self = [super initWithFrame:CGRectMakeWithSize(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT))];
    if (self) {
        self.seconds = seconds;
        self.callback = callback;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        UILabel *label = [[UILabel alloc] initForAutoLayout];
        label.font = CodeFontMake(100);
        label.textColor = UIColor.whiteColor;
        [self addSubview:label];
        label.text = [NSString stringWithFormat:@"%d", self.seconds];
        [label autoCenterInSuperview];
        self.label = label;
    }
    return self;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    __weak __typeof(self)weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        weakSelf.seconds -= 1;
        weakSelf.label.text = [NSString stringWithFormat:@"%d", weakSelf.seconds];
        if (weakSelf.seconds == 0) {
            if (weakSelf.callback) {
                weakSelf.callback();
            }
            [weakSelf removeFromSuperview];
        }
    }];
}

@end
