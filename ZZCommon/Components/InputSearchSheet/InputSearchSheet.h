//
//  InputSearchSheet.h
//  SmartManage
//
//  Created by mac on 2023/3/29.
//

#import <Foundation/Foundation.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputSearchSheet : QMUIModalPresentationViewController

/**
 选择回调
 */
@property(nonatomic, copy) void(^didSelectItemBlock)(id item);
/**
 要展示的名称的回调
 */
@property(nonatomic, copy) NSString *(^itemNameBlock)(id item);

- (instancetype)initAlertWithItems:(NSArray *)items selectItem:(nullable id)selectItem title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
