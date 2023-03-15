//
//  NSDictionary+Extension.h

//  Created by westMac on 2021/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)

- (NSString  * _Nullable)jsonString;

/*!

 * @brief 把格式化的JSON格式的字符串转换成字典

 * @param jsonString JSON格式的字符串

 * @return 返回字典

 */
+ (NSDictionary *)dictionaryWithJsonString: (NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
