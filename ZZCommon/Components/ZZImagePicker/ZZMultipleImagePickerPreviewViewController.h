//
//  ZZMultipleImagePickerPreviewViewController.h
//

#import <QMUIKit/QMUIKit.h>

@class ZZMultipleImagePickerPreviewViewController;

@protocol ZZMultipleImagePickerPreviewViewControllerDelegate <QMUIImagePickerPreviewViewControllerDelegate>

@required
- (void)imagePickerPreviewViewController:(ZZMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray;

@end

@interface ZZMultipleImagePickerPreviewViewController : QMUIImagePickerPreviewViewController

@property(nonatomic, weak) id<ZZMultipleImagePickerPreviewViewControllerDelegate> delegate;
@property(nonatomic, strong) QMUILabel *imageCountLabel;
@property(nonatomic, strong) QMUIAssetsGroup *assetsGroup;
@property(nonatomic, assign) BOOL shouldUseOriginImage;

@end
