//
//  ZZImagePreviewViewController.h

//  Created by westMac on 2021/12/28.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZImagePreviewViewController : QMUIImagePreviewViewController

+ (void)showImagePreview:(NSArray *)imageObjs
            currentIndex:(NSUInteger)currentIndex
              sourceView:(UIView *)sourceView
          showSaveBotton:(BOOL)showSaveBotton
        showDeleteButton:(BOOL)showDeleteButton
   scrollSourceViewBlock:(nullable UIView *(^)(NSUInteger index, UIView *sourceView)) scrollSourceViewBlock
             deleteBlock:(nullable BOOL(^)(NSUInteger index)) deleteBlock;

@end

NS_ASSUME_NONNULL_END
