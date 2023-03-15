//
//  DownPopupMenuButton.h

//  Created by mac on 2022/3/10.
//

#import <QMUIKit/QMUIKit.h>
#import "PopupMenuButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownPopupMenuButton<T:NSObject *> : PopupMenuButton<T>

/**
 左标题，注意字数不要太多，如：科目:
 */
@property(nonatomic, strong) NSString *leftTitle;

@end

NS_ASSUME_NONNULL_END
