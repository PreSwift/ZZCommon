//
//  SingleUploadImage.h

//  Created by westMac on 2021/8/17.
//

#import <Foundation/Foundation.h>
#import "ZZImagePickerController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZZImagePickerSourceType) {
    ZZImagePickerSourceTypeCamera,
    ZZImagePickerSourceTypeAlbum,
    ZZImagePickerSourceTypeBoth
};

@class ZZImagePicker;

@protocol ZZImagePickerDelegate <NSObject>

@optional

- (void)imagePickerDidCancel: (ZZImagePicker *)imagePicker;

- (void)imagePicker:(ZZImagePicker *)imagePicker didTakeAPicture:(UIImage *)image tempLocalCacheUrl:(NSString *)tempLocalCacheUrl;

- (void)imagePicker:(ZZImagePicker *)imagePicker didSelected:(NSArray<QMUIAsset *> *)assets;

@end

@interface ZZImagePicker : NSObject

- (void)showPicker;

- (void)authorizationPresentAlbumViewController:(BOOL)isCamera;

@property(nonatomic, assign) ZZImagePickerSourceType sourceType;

@property(nonatomic, assign) NSInteger tag;

@property(nonatomic, assign) NSInteger imagePickingTag;

@property(nonatomic, assign) NSUInteger maxCount;

@property(nonatomic, weak) id<ZZImagePickerDelegate> imagePickerdelegate;

@property(nonatomic, assign) BOOL shouldSaveToAlbum;

/// 当前被选择的图片对应的 QMUIAsset 对象数组
@property(nullable, nonatomic, strong) NSArray<QMUIAsset *> *selectedImageAssetArray;

@end

NS_ASSUME_NONNULL_END
