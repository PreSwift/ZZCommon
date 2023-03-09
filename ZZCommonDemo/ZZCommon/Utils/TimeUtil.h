//
//  TimeUtil.h
//  teacher
//
//  Created by westMac on 2021/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeUtil : NSObject

/**
 根据日期获取时间字符串
 输出格式：yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)formatTimeFromDate: (NSDate *)date;

/**
 根据时间字符串获取日期
 dateStr：格式yyyy-MM-dd HH:mm:ss
 */
+ (NSDate *)formatTimeFromDateStr: (NSString *)dateStr;


/**
 根据秒数获取时钟字符串
 输出格式：15:56:03表示15小时56分3秒，08:06表示8分6秒
 */
+ (NSString *)formatTimeStrFromSecond: (NSUInteger)seconds;

/**
 根据时间全字符串获取日期
 dateStr：格式yyyy-MM-dd HH:mm:ss 输出格式yyyy-MM-dd
 */
+ (NSString *)getJustDateFromFullDateStr:(NSString *)dateStr;

/**
 根据时间全字符串获取不显示秒数的字符串
 dateStr：格式yyyy-MM-dd HH:mm:ss 输出格式：yyyy-MM-dd HH:mm
 */
+ (NSString *)getNoSecondTimeFromFullDateStr: (NSString *)dateStr;

@end

NS_ASSUME_NONNULL_END
