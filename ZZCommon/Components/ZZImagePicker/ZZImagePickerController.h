//
//  ZZImagePickerViewController.h

//  Created by westMac on 2021/9/6.
//

#import <QMUIKit/QMUIKit.h>
#import "ZZMultipleImagePickerPreviewViewController.h"
#import "ZZSingleImagePickerPreviewViewController.h"

NS_ASSUME_NONNULL_BEGIN

#define MaxSelectedImageCount INT_MAX
#define NormalImagePickingTag 1045
#define ModifiedImagePickingTag 1046
#define MultipleImagePickingTag 1047
#define SingleImagePickingTag 1048

@class ZZImagePickerController;

@protocol ZZImagePickerControllerDelegate <NSObject>

- (void)imagePikcer: (ZZImagePickerController *)imagePicker didselected: (NSArray<QMUIAsset *> *)imageAssets;

@end

static QMUIAlbumContentType const kAlbumContentType = QMUIAlbumContentTypeAll;

@interface ZZImagePickerController : QMUIAlbumViewController

@property(nonatomic, assign) NSInteger imagePickingTag;

@property(nonatomic, assign) NSUInteger maxCount;

@property(nonatomic, weak) id <ZZImagePickerControllerDelegate> delegate;

/// 当前被选择的图片对应的 QMUIAsset 对象数组
@property(nullable, nonatomic, strong, readonly) NSMutableArray<QMUIAsset *> *selectedImageAssetArray;

- (void)showImagePicker;

+ (UIImage *)getImageFromAsset: (NSData *)imageData isGIF: (BOOL)isGIF isHEIC: (BOOL)isHEIC;

@end

NS_ASSUME_NONNULL_END
