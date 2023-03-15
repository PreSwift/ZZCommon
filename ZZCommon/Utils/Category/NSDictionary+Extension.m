//
//  NSDictionary+Extension.m

//  Created by westMac on 2021/12/10.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)jsonString {
    NSError *error = nil;
    NSData *jsonData = nil;
    if (!self) {
      return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
      NSString *keyString = nil;
      NSString *valueString = nil;
      if ([key isKindOfClass:[NSString class]]) {
        keyString = key;
      }else{
        keyString = [NSString stringWithFormat:@"%@",key];
      }
     
      if ([obj isKindOfClass:[NSString class]]) {
        valueString = obj;
      } else if ([obj isKindOfClass:[NSArray class]]) {
        valueString = @"";
      } else {
        valueString = [NSString stringWithFormat:@"%@",obj];
      }
     
      [dict setObject:valueString forKey:keyString];
    }];
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] == 0 || error != nil) {
      return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

/*!

 * @brief 把格式化的JSON格式的字符串转换成字典

 * @param jsonString JSON格式的字符串

 * @return 返回字典

 */
+ (NSDictionary *)dictionaryWithJsonString: (NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];

    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
