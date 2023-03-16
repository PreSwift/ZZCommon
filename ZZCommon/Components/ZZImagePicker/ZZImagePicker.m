//
//  SingleUploadImage.m

//  Created by westMac on 2021/8/17.
//

#import "ZZImagePicker.h"

@interface ZZImagePicker() <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZZImagePickerControllerDelegate>

@end

@implementation ZZImagePicker

- (void)dealloc
{
    NSLog(@"%@", self.class);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imagePickingTag = MultipleImagePickingTag;
        self.maxCount = MaxSelectedImageCount;
        self.sourceType = ZZImagePickerSourceTypeBoth;
    }
    return self;
}

- (void)showPicker {
    if (self.sourceType == ZZImagePickerSourceTypeBoth) {
        QMUIAlertController *alertController = [[QMUIAlertController alloc] initWithTitle:nil message:nil preferredStyle:QMUIAlertControllerStyleActionSheet];
        if (alertController) {
            alertController.sheetButtonAttributes = @{NSForegroundColorAttributeName:UIColor.qd_titleTextColor,NSFontAttributeName:UIFont.qd_mainTextFont,NSKernAttributeName:@(0)};
            alertController.sheetCancelButtonAttributes = @{NSForegroundColorAttributeName:UIColor.qd_titleTextColor,NSFontAttributeName:UIFont.qd_mainTextFont,NSKernAttributeName:@(0)};
            __weak __typeof(self)weakSelf = self;
            QMUIAlertAction *cancelAction = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:cancelAction];
            QMUIAlertAction *cameraAction = [QMUIAlertAction actionWithTitle:@"拍照" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
                [weakSelf authorizationPresentAlbumViewController:YES];
            }];
            [alertController addAction:cameraAction];
            QMUIAlertAction *photoAction = [QMUIAlertAction actionWithTitle:@"从手机相册中选择" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController * _Nonnull aAlertController, QMUIAlertAction * _Nonnull action) {
                [weakSelf authorizationPresentAlbumViewController:NO];
            }];
            [alertController addAction:photoAction];
        }
        [alertController showWithAnimated:YES];
    } else if (self.sourceType == ZZImagePickerSourceTypeCamera) {
        [self authorizationPresentAlbumViewController:YES];
    } else if (self.sourceType == ZZImagePickerSourceTypeAlbum) {
        [self authorizationPresentAlbumViewController:NO];
    }
}

- (void)authorizationPresentAlbumViewController:(BOOL)isCamera {
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC);
    __weak __typeof(self)weakSelf = self;
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        if ([QMUIAssetsManager authorizationStatus] == QMUIAssetAuthorizationStatusNotDetermined) {
            [QMUIAssetsManager requestAuthorization:^(QMUIAssetAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == QMUIAssetAuthorizationStatusAuthorized) {
                        [weakSelf presentAlbumViewController:isCamera];
                    } else {
                        [QDUITips showWithText:@"权限获取失败" inView:QMUIHelper.visibleViewController.view];
                    }
                });
            }];
        } else if ([QMUIAssetsManager authorizationStatus] == QMUIAssetAuthorizationStatusAuthorized) {
            [weakSelf presentAlbumViewController:isCamera];
        } else {
            [QDUITips showWithText:@"权限获取失败" inView:QMUIHelper.visibleViewController.view];
        }
    });
}

- (void)presentAlbumViewController: (BOOL)isCamera {
    // 创建一个 QMUIAlbumViewController 实例用于呈现相簿列表
    if (isCamera) {
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        imagePickerVC.delegate = self;
        [[QMUIHelper visibleViewController] presentViewController:imagePickerVC animated:YES completion:NULL];
    } else {
        ZZImagePickerController *imagePickerVC = [[ZZImagePickerController alloc] init];
        imagePickerVC.imagePickingTag = _imagePickingTag;
        imagePickerVC.maxCount = _maxCount;
        imagePickerVC.delegate = self;
        [imagePickerVC.selectedImageAssetArray addObjectsFromArray:_selectedImageAssetArray];
        [imagePickerVC showImagePicker];
    }
 }


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info[UIImagePickerControllerOriginalImage] fixOrientation];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && self.shouldSaveToAlbum) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    NSString *tmpDir =  NSTemporaryDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [tmpDir stringByAppendingString:[NSString stringWithFormat:@"tempPick_%f.png", [NSDate.new timeIntervalSince1970]]];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    if (self.imagePickerdelegate) {
        [self.imagePickerdelegate imagePicker:self didTakeAPicture:image tempLocalCacheUrl:imagePath];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <ZZImagePickerControllerDelegate>

- (void)imagePikcer:(ZZImagePickerController *)imagePicker didselected:(NSArray<QMUIAsset *> *)imageAssets {
    if (self.imagePickerdelegate) {
        [self.imagePickerdelegate imagePicker:self didSelected:imageAssets];
    }
}

@end
