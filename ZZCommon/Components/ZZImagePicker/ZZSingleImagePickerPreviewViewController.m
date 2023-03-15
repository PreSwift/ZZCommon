//
//  ZZSingleImagePickerPreviewViewController.m
//

#import "ZZSingleImagePickerPreviewViewController.h"

@implementation ZZSingleImagePickerPreviewViewController {
    QMUIButton *_confirmButton;
}

@dynamic delegate;

- (void)tapGetshow {
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)initSubviews {
    [super initSubviews];
    
    [self.backButton addTarget:self action:@selector(tapGetshow) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmButton = [[QMUIButton alloc] init];
    _confirmButton.qmui_outsideEdge = UIEdgeInsetsMake(-6, -6, -6, -6);
    [_confirmButton setTitleColor:self.toolBarTintColor forState:UIControlStateNormal];
    [_confirmButton setTitle:@"使用" forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(handleUserAvatarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmButton sizeToFit];
    [self.topToolBarView addSubview:_confirmButton];
}

- (void)setDownloadStatus:(QMUIAssetDownloadStatus)downloadStatus {
    [super setDownloadStatus:downloadStatus];
    switch (downloadStatus) {
        case QMUIAssetDownloadStatusSucceed:
            _confirmButton.hidden = NO;
            break;
            
        case QMUIAssetDownloadStatusDownloading:
            _confirmButton.hidden = YES;
            break;
            
        case QMUIAssetDownloadStatusCanceled:
            _confirmButton.hidden = NO;
            break;
            
        case QMUIAssetDownloadStatusFailed:
            _confirmButton.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _confirmButton.frame = CGRectSetXY(_confirmButton.frame, CGRectGetWidth(self.topToolBarView.frame) - CGRectGetWidth(_confirmButton.frame) - 10, CGRectGetMinY(self.backButton.frame) + CGFloatGetCenter(CGRectGetHeight(self.backButton.frame), CGRectGetHeight(_confirmButton.frame)));
}

- (void)handleUserAvatarButtonClick:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^(void) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerPreviewViewController:didSelectImageWithImagesAsset:)]) {
            QMUIAsset *imageAsset = [self.imagesAssetArray objectAtIndex:self.imagePreviewView.currentImageIndex];
            [self.delegate imagePickerPreviewViewController:self didSelectImageWithImagesAsset:imageAsset];
        }
    }];
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

@end
