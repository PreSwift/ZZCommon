//
//  ZZSingleImagePickerPreviewViewController.h
//

@class ZZSingleImagePickerPreviewViewController;

@protocol ZZSingleImagePickerPreviewViewControllerDelegate <QMUIImagePickerPreviewViewControllerDelegate>

@required
- (void)imagePickerPreviewViewController:(ZZSingleImagePickerPreviewViewController *)imagePickerPreviewViewController didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset;

@end

@interface ZZSingleImagePickerPreviewViewController : QMUIImagePickerPreviewViewController

@property(nonatomic, weak) id<ZZSingleImagePickerPreviewViewControllerDelegate> delegate;
@property(nonatomic, strong) QMUIAssetsGroup *assetsGroup;

@end
