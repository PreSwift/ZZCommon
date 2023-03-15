//
//  SingleUploadImage.h
//  teacher
//
//  Created by westMac on 2021/8/17.
//

#import <Foundation/Foundation.h>
#import "ZZImagePickerController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QDImagePickerSourceType) {
    QDImagePickerSourceTypeCamera,
    QDImagePickerSourceTypeAlbum,
    QDImagePickerSourceTypeBoth
};

@class QDImagePicker;

@protocol QDImagePickerDelegate <NSObject>

@optional

- (void)imagePickerDidCancel: (QDImagePicker *)imagePicker;

- (void)imagePicker:(QDImagePicker *)imagePicker didTakeAPicture:(UIImage *)image tempLocalCacheUrl:(NSString *)tempLocalCacheUrl;

- (void)imagePicker:(QDImagePicker *)imagePicker didSelected:(NSArray<QMUIAsset *> *)assets;

@end

@interface QDImagePicker : NSObject

- (void)showPicker;

- (void)authorizationPresentAlbumViewController:(BOOL)isCamera;

@property(nonatomic, assign) QDImagePickerSourceType sourceType;

@property(nonatomic, assign) NSInteger tag;

@property(nonatomic, assign) NSInteger imagePickingTag;

@property(nonatomic, assign) NSUInteger maxCount;

@property(nonatomic, weak) id<QDImagePickerDelegate> imagePickerdelegate;

@property(nonatomic, assign) BOOL shouldSaveToAlbum;

/// 当前被选择的图片对应的 QMUIAsset 对象数组
@property(nullable, nonatomic, strong) NSArray<QMUIAsset *> *selectedImageAssetArray;

@end

NS_ASSUME_NONNULL_END
