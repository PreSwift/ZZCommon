//
//  ZZImagePickerViewController.m

//  Created by westMac on 2021/9/6.
//

#import "ZZImagePickerController.h"
#import "ZZCommonMacros.h"

@interface ZZImagePickerController () <QMUIAlbumViewControllerDelegate, QMUIImagePickerViewControllerDelegate, ZZMultipleImagePickerPreviewViewControllerDelegate, ZZSingleImagePickerPreviewViewControllerDelegate>

@property(nonatomic, assign) int cacheCount;

@end

@implementation ZZImagePickerController

- (void)dealloc
{
    NSLog(@"%@", self.class);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.albumViewControllerDelegate = self;
        _selectedImageAssetArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)initSubviews {
    [super initSubviews];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)showImagePicker {
    // 创建一个 QMUIAlbumViewController 实例用于呈现相簿列表
    self.view.tag = _imagePickingTag;
    if (self.view.tag == ModifiedImagePickingTag) {
        self.albumTableViewCellHeight = 70;
    }
    ZZNavigationController *navigationController = [[ZZNavigationController alloc] initWithRootViewController:self];
    // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
    [self pickLastAlbumGroupDirectlyIfCan];
    [[QMUIHelper visibleViewController] presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - <QMUIAlbumViewControllerDelegate>

- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController {
    QMUIImagePickerViewController *imagePickerViewController = [[QMUIImagePickerViewController alloc] init];
    imagePickerViewController.supportedOrientationMask = self.supportedOrientationMask;
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    imagePickerViewController.maximumSelectImageCount = _maxCount;
    [imagePickerViewController refreshWithAssetsGroup:nil];
    [imagePickerViewController.selectedImageAssetArray addObjectsFromArray:self.selectedImageAssetArray];
    imagePickerViewController.view.tag = albumViewController.view.tag;
    [imagePickerViewController.sendButton setTitle:@"确定" forState:UIControlStateNormal];
    if (albumViewController.view.tag == SingleImagePickingTag) {
        imagePickerViewController.allowsMultipleSelection = NO;
    }
    if (albumViewController.view.tag == ModifiedImagePickingTag) {
        imagePickerViewController.minimumImageWidth = 65;
    }
    return imagePickerViewController;
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>

- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerViewController.assetsGroup ablumContentType:kAlbumContentType userIdentify:nil];
    
    [self sendImageWithImagesAssetArray:imagesAssetArray];
}

- (QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController {
    if (imagePickerViewController.view.tag == MultipleImagePickingTag) {
        ZZMultipleImagePickerPreviewViewController *imagePickerPreviewViewController = [[ZZMultipleImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.supportedOrientationMask = self.supportedOrientationMask;
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.maximumSelectImageCount = MaxSelectedImageCount;
        imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        return imagePickerPreviewViewController;
    } else if (imagePickerViewController.view.tag == SingleImagePickingTag) {
        ZZSingleImagePickerPreviewViewController *imagePickerPreviewViewController = [[ZZSingleImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.supportedOrientationMask = self.supportedOrientationMask;
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        return imagePickerPreviewViewController;
    } else if (imagePickerViewController.view.tag == ModifiedImagePickingTag) {
        QMUIImagePickerPreviewViewController *imagePickerPreviewViewController = [[QMUIImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.supportedOrientationMask = self.supportedOrientationMask;
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        imagePickerPreviewViewController.toolBarBackgroundColor = UIColorMake(66, 66, 66);
        return imagePickerPreviewViewController;
    } else {
        QMUIImagePickerPreviewViewController *imagePickerPreviewViewController = [[QMUIImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.supportedOrientationMask = self.supportedOrientationMask;
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        return imagePickerPreviewViewController;
    }
}

#pragma mark - <QMUIImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didCheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didUncheckImageAtIndex:(NSInteger)index {
    [self updateImageCountLabelForPreviewView:imagePickerPreviewViewController];
}

// 更新选中的图片数量
- (void)updateImageCountLabelForPreviewView:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController {
    if (imagePickerPreviewViewController.view.tag == MultipleImagePickingTag) {
        ZZMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (ZZMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
        customImagePickerPreviewViewController.supportedOrientationMask = self.supportedOrientationMask;
        NSUInteger selectedCount = [imagePickerPreviewViewController.selectedImageAssetArray count];
        if (selectedCount > 0) {
            customImagePickerPreviewViewController.imageCountLabel.text = [[NSString alloc] initWithFormat:@"%@", @(selectedCount)];
            customImagePickerPreviewViewController.imageCountLabel.hidden = NO;
            [QMUIImagePickerHelper springAnimationOfImageSelectedCountChangeWithCountLabel:customImagePickerPreviewViewController.imageCountLabel];
        } else {
            customImagePickerPreviewViewController.imageCountLabel.hidden = YES;
        }
    }
}

#pragma mark - <ZZMultipleImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(ZZMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerPreviewViewController.assetsGroup ablumContentType:kAlbumContentType userIdentify:nil];
    [self sendImageWithImagesAssetArray:imagesAssetArray];
}

#pragma mark - <ZZSingleImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(ZZSingleImagePickerPreviewViewController *)imagePickerPreviewViewController didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset {
    // 储存最近选择了图片的相册，方便下次直接进入该相册
    [QMUIImagePickerHelper updateLastestAlbumWithAssetsGroup:imagePickerPreviewViewController.assetsGroup ablumContentType:kAlbumContentType userIdentify:nil];
    [self sendImageWithImagesAssetArray:[NSMutableArray arrayWithObject:imageAsset]];
    
}

#pragma mark - 业务方法

- (void)startLoading {
    [ZZUITips showLoading:@"下载中..." detailText:@"正在从iCloud同步下载图片，请稍后" inView:[UIApplication sharedApplication].keyWindow];
}

- (void)stopLoading {
    [ZZUITips hideAllTips];
}

- (void)showTipLabelWithText:(NSString *)text {
    [self stopLoading];
    [ZZUITips showWithText:text inView:[UIApplication sharedApplication].keyWindow hideAfterDelay:1.0];
}


- (void)sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    if ([QMUIImagePickerHelper imageAssetsDownloaded:imagesAssetArray]) {
        // 所有资源从 iCloud 下载成功
        if (self.delegate) {
            [self.delegate imagePikcer:self didselected:imagesAssetArray];
        }
        [self stopLoading];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        self.cacheCount = 0;
        NSInteger targetCount = imagesAssetArray.count;
        NSMutableArray<QMUIAsset *> *tempArray = [NSMutableArray arrayWithArray:imagesAssetArray];
        for (QMUIAsset *asset in imagesAssetArray) {
            [QMUIImagePickerHelper requestImageAssetIfNeeded:asset completion:^(QMUIAssetDownloadStatus downloadStatus, NSError *error) {
                if (downloadStatus == QMUIAssetDownloadStatusCanceled || downloadStatus == QMUIAssetDownloadStatusFailed) {
                    [self showTipLabelWithText:@"iCloud图片下载错误，请重新选图"];
                } else {
                    if (downloadStatus == QMUIAssetDownloadStatusDownloading) {
                        NSLog(@"下载iCloud图片：%@", asset.identifier);
                        [self startLoading];
                    } else if (downloadStatus == QMUIAssetDownloadStatusSucceed) {
                        self.cacheCount += 1;
                        NSLog(@"获取图片完成：%@,    %d    %ld", asset.identifier, self.cacheCount, targetCount);
                        if (self.cacheCount == targetCount) {
                            [self sendImageWithImagesAssetArray:tempArray];
                        }
                    }
                }
            }];
        }
    }
}

+ (UIImage *)getImageFromAsset:(NSData *)imageData isGIF:(BOOL)isGIF isHEIC:(BOOL)isHEIC {
    UIImage *targetImage = nil;
    if (isGIF) {
        targetImage = [UIImage qmui_animatedImageWithData:imageData];
    } else {
        targetImage = [UIImage imageWithData:imageData];
        if (isHEIC) {
            // iOS 11 中新增 HEIF/HEVC 格式的资源，直接发送新格式的照片到不支持新格式的设备，照片可能会无法识别，可以先转换为通用的 JPEG 格式再进行使用。
            // 详细请浏览：https://github.com/Tencent/QMUI_iOS/issues/224
            targetImage = [UIImage imageWithData:UIImageJPEGRepresentation(targetImage, 0.5)];
        }
    }
    return targetImage;
}

@end
