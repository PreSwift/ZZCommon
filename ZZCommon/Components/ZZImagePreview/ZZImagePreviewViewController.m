//
//  ZZImagePreviewViewController.m

//  Created by westMac on 2021/12/28.
//

#import "ZZImagePreviewViewController.h"
#import "ZZImagePickerController.h"

@interface ZZImagePreviewViewController () <QMUIImagePreviewViewDelegate>

@property(nonatomic, assign) BOOL isShowToolBar;
@property(nonatomic, strong) UIView *topToolBar;
@property(nonatomic, strong) QMUINavigationButton *backButton;
@property(nonatomic, strong) UILabel *numberLabel;
@property(nonatomic, strong) UIView *bottomToolBar;
@property(nonatomic, strong) UIButton *saveBtn;
@property(nonatomic, strong) UIButton *deleteBtn;
@property(nonatomic, strong) NSLayoutConstraint *topHeightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *bottomHeightConstraint;

@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) UIView *sourceView;
@property(nonatomic, assign, getter=isShowSaveBtn) BOOL showSaveBtn;
@property(nonatomic, assign, getter=isShowDeleteBtn) BOOL showDeleteBtn;
@property(nonatomic, strong) UIView *(^scrollSourceViewBlock)(NSUInteger index, UIView *sourceView);
@property(nonatomic, copy) BOOL(^deleteBlock)(NSUInteger index);

@end

@implementation ZZImagePreviewViewController

+ (void)showImagePreview:(NSArray *)imageObjs currentIndex:(NSUInteger)currentIndex sourceView:(UIView *)sourceView showSaveBotton:(BOOL)showSaveBotton showDeleteButton:(BOOL)showDeleteButton scrollSourceViewBlock:(nullable UIView * _Nonnull (^)(NSUInteger, UIView * _Nonnull))scrollSourceViewBlock deleteBlock:(nullable BOOL (^)(NSUInteger))deleteBlock {
    ZZImagePreviewViewController *imagePreviewViewController = [[ZZImagePreviewViewController alloc] init];
    imagePreviewViewController.images = [NSMutableArray arrayWithArray:imageObjs];
    imagePreviewViewController.sourceView = sourceView;
    imagePreviewViewController.showSaveBtn = showSaveBotton;
    imagePreviewViewController.showDeleteBtn = showDeleteButton;
    imagePreviewViewController.scrollSourceViewBlock = scrollSourceViewBlock;
    imagePreviewViewController.deleteBlock = deleteBlock;
    imagePreviewViewController.imagePreviewView.delegate = imagePreviewViewController;
    imagePreviewViewController.imagePreviewView.currentImageIndex = currentIndex;// 默认展示的图片 index
    // 如果使用 zoom 动画，则需要在 sourceImageView 里返回一个 UIView，由这个 UIView 的布局位置决定动画的起点/终点，如果用 fade 则不需要使用 sourceImageView。
    // 另外当 sourceImageView 返回 nil 时会强制使用 fade 动画，常见的使用场景是 present 时 sourceImageView 还在屏幕内，但 dismiss 时 sourceImageView 已经不在可视区域，即可通过返回 nil 来改用 fade 动画。
    imagePreviewViewController.sourceImageView = ^UIView *{
        return sourceView;
    };
    [QMUIHelper.visibleViewController presentViewController:imagePreviewViewController animated:YES completion:nil];
}

- (UIInterfaceOrientationMask)supportedOrientationMask {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)dealloc {
    NSLog(@"%@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isShowToolBar = YES;
    
    __weak __typeof(self)weakSelf = self;
    self.view.qmui_frameDidChangeBlock = ^(__kindof UIView * _Nonnull view, CGRect precedingFrame) {
        if (precedingFrame.size.width > 0 && precedingFrame.size.height > 0) {
            [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:NO block:^(NSTimer * _Nonnull timer) {
                weakSelf.topHeightConstraint.constant = IS_LANDSCAPE ? SS(44) : (SafeAreaInsetsConstantForDeviceWithNotch.top + SS(44));
                weakSelf.bottomHeightConstraint.constant = IS_LANDSCAPE ? SS(44) : (SafeAreaInsetsConstantForDeviceWithNotch.bottom + SS(44));
            }];
        }
    };
}

- (void)initSubviews {
    [super initSubviews];
    
    _topToolBar = [[UIView alloc] initForAutoLayout];
    _topToolBar.backgroundColor = QMUIImagePickerPreviewViewController.appearance.toolBarBackgroundColor;
    [self.view addSubview:_topToolBar];
    [_topToolBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    _topHeightConstraint = [_topToolBar autoSetDimension:ALDimensionHeight toSize:SafeAreaInsetsConstantForDeviceWithNotch.top + SS(44)];
    
    _backButton = [[QMUINavigationButton alloc] initWithType:QMUINavigationButtonTypeBack];
    _backButton.tintColor = UIColor.whiteColor;
    [self.backButton addTarget:self action:@selector(handleCancelPreviewImage:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.qmui_outsideEdge = UIEdgeInsetsMake(-30, -20, -50, -80);
    [self.topToolBar addSubview:self.backButton];
    [self.backButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:SS(11)];
    [self.backButton autoPinEdgeToSuperviewSafeArea:ALEdgeLeft withInset:SS(16)];
    
    _numberLabel = [[UILabel alloc] initForAutoLayout];
    _numberLabel.textColor = UIColorWhite;
    _numberLabel.font = CodeFontMake(SS(16));
    _numberLabel.text = [NSString stringWithFormat:@"%ld / %ld", self.imagePreviewView.currentImageIndex + 1, self.images.count];
    [self.topToolBar addSubview:_numberLabel];
    [_numberLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_numberLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_backButton];
    
    if (_showSaveBtn || _showDeleteBtn) {
        _bottomToolBar = [[UIView alloc] initForAutoLayout];
        _bottomToolBar.backgroundColor = _topToolBar.backgroundColor;
        [self.view addSubview:_bottomToolBar];
        [self.bottomToolBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        _bottomHeightConstraint = [self.bottomToolBar autoSetDimension:ALDimensionHeight toSize:SafeAreaInsetsConstantForDeviceWithNotch.bottom + SS(44)];
        
        if (_showSaveBtn) {
            _saveBtn = [[UIButton alloc] initForAutoLayout];
            [_saveBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
            [_saveBtn addTarget:self action:@selector(tapSaveBtn) forControlEvents:UIControlEventTouchUpInside];
            [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
            _saveBtn.titleLabel.font = CodeFontMake(SS(16));
            _saveBtn.qmui_outsideEdge = UIEdgeInsetsMake(-15, -15, -15, -15);
            [self.bottomToolBar addSubview:_saveBtn];
            [_saveBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SS(11)];
            [_saveBtn autoPinEdgeToSuperviewSafeArea:ALEdgeLeft withInset:SS(15)];
            [_saveBtn autoSetDimension:ALDimensionHeight toSize:SS(20)];
        }
        
        if (_showDeleteBtn) {
            _deleteBtn = [[UIButton alloc] initForAutoLayout];
            [_deleteBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
            [_deleteBtn addTarget:self action:@selector(tapDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
            [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
            _deleteBtn.titleLabel.font = CodeFontMake(SS(16));
            _deleteBtn.qmui_outsideEdge = UIEdgeInsetsMake(-15, -15, -15, -15);
            [self.bottomToolBar addSubview:_deleteBtn];
            [_deleteBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:SS(11)];
            [_deleteBtn autoPinEdgeToSuperviewSafeArea:ALEdgeRight withInset:SS(15)];
            [_deleteBtn autoSetDimension:ALDimensionHeight toSize:SS(20)];
        }
    }
}

- (void)handleCancelPreviewImage:(UIControl *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapSaveBtn {
    UIImage *image = [self.imagePreviewView zoomImageViewAtIndex:self.imagePreviewView.currentImageIndex].image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)tapDeleteBtn {
    if (self.images.count == 0) {
        return;
    }
    NSInteger index = self.imagePreviewView.currentImageIndex;
    if (self.deleteBlock) {
        if (self.deleteBlock(index)) {
            [self handleCancelPreviewImage:nil];
        }
    }
    [self.images removeObjectAtIndex:index];
    [self.imagePreviewView.collectionView reloadData];
    if (self.images.count <= index) {
        index = self.images.count - 1;
    }
    [self.imagePreviewView setCurrentImageIndex:index animated:YES];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld / %ld", index + 1, self.images.count];
    if (self.images.count == 0) {
        [self handleCancelPreviewImage:nil];
    }
}

- (void)animationShowToolBar {
    if (self.isShowToolBar == NO) {
        self.isShowToolBar = YES;
        self.topToolBar.hidden = NO;
        self.bottomToolBar.hidden = NO;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.topToolBar.alpha = 1;
            self.bottomToolBar.alpha = 1;
        } completion:nil];
    }
}

- (void)animationHideToolBar {
    if (self.isShowToolBar == YES) {
        self.isShowToolBar = NO;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.topToolBar.alpha = 0;
            self.bottomToolBar.alpha = 0;
        } completion:^(BOOL finished) {
            self.topToolBar.hidden = YES;
            self.bottomToolBar.hidden = YES;
        }];
    }
}

#pragma mark - <QMUIImagePreviewViewDelegate>

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return self.images.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    zoomImageView.reusedIdentifier = @(index);
    id obj = _images[index];
    // 模拟异步加载的情况
    if ([obj isKindOfClass:[NSString class]]) {
        if ([((NSString *)obj) containsString:@"http"]) {
            [zoomImageView showLoading];
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:obj] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if ([zoomImageView.reusedIdentifier isEqual:@(index)]) {
                    [zoomImageView hideEmptyView];
                    zoomImageView.image = image;
                }
            }];
        } else {
            [zoomImageView setImage:[[UIImage alloc] initWithContentsOfFile:obj]];
        }
    } else if ([obj isKindOfClass:[QMUIAsset class]]) {
        [zoomImageView showLoading];
        [((QMUIAsset *)obj) requestImageData:^(NSData *imageData, NSDictionary<NSString *,id> *info, BOOL isGIF, BOOL isHEIC) {
            if ([zoomImageView.reusedIdentifier isEqual:@(index)]) {
                [zoomImageView hideEmptyView];
                zoomImageView.image = [ZZImagePickerController getImageFromAsset:imageData isGIF:isGIF isHEIC:isHEIC];
            }
        }];
    } else {
        zoomImageView.image = self.images[index];
    }
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView willScrollHalfToIndex:(NSUInteger)index {
    self.numberLabel.text = [NSString stringWithFormat:@"%ld / %ld", index + 1, self.images.count];
}

- (QMUIImagePreviewMediaType)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView assetTypeAtIndex:(NSUInteger)index {
    return QMUIImagePreviewMediaTypeImage;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView didScrollToIndex:(NSUInteger)index {
    // 由于进入大图查看模式后可以左右滚动切换图片，最终退出时要退出到当前大图所对应的小图那，所以需要在适当的时机（这里选择 imagePreviewView:didScrollToIndex:）更新 sourceImageView 的值
    __weak __typeof(self)weakSelf = self;
    self.sourceImageView = ^UIView *{
        if (weakSelf.scrollSourceViewBlock) {
            return weakSelf.scrollSourceViewBlock(index, weakSelf.sourceView);
        }
        return weakSelf.sourceView;
    };
}

#pragma mark -- <保存到相册>
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [QDUITips showWithText:msg inView:self.view];
}


#pragma mark - <QMUIZoomImageViewDelegate>

- (void)singleTouchInZoomingImageView:(QMUIZoomImageView *)zoomImageView location:(CGPoint)location {
    // 退出图片预览
    if (self.isShowToolBar) {
        [self animationHideToolBar];
    } else {
        [self animationShowToolBar];
    }
}

@end
