//
//  NSStringUtil.h
//  student
//
//  Created by westMac on 2021/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSStringUtil : NSObject

/**
 * 大于1万的显示xx万
 */
+ (NSString *)formatCount: (NSInteger)count;
/**
 * 展示分数， 小数保留2位数字展示，如果分数未-1，则显示为--
 */
+ (NSString *)showScore: (CGFloat)score;
/**
 * 小数保留2位数字展示
 */
+ (NSString *)formatFloatNumber: (CGFloat)score;
/**
 *  将阿拉伯数字转换为中文数字
 */
+ (NSString *)translationArabicNum:(NSInteger)arabicNum;
/**
 * 正则匹配手机号
 */
+ (BOOL)checkTelNumber:(NSString *) telNumber;
/**
 * 正则匹配用户密码6-18位数字和字母组合
 */
+ (BOOL)checkPassword:(NSString *) password;
/**
 * 正则匹配用户姓名,20位的中文或英文
 */
+ (BOOL)checkUserName : (NSString *) userName;
/**
 * 正则匹配用户身份证号
 */
+ (BOOL)checkUserIdCard: (NSString *) idCard;
/**
 * 正则匹配URL
 */
+ (BOOL)checkURL : (NSString *) url;
/**
 * String null过滤
 */
+ (NSString *)checkNull:(nullable NSString *)showStr;
/**
 * String null过滤
 */
+ (NSString *)checkNull:(nullable NSString *)showStr placeholder:(nullable NSString *)placeholder;

/**
 url后面增加时间戳
 */
+ (NSString *)addTimestamp:(NSString *)url;

/**
 *    去除字符串中连续换行，只保留结尾处换行
 *    allStr 字符串
 *    return 去除连续换行后的字符串
 */
+ (NSString *)trimAllNewline:(NSString *)allStr;

@end

NS_ASSUME_NONNULL_END
