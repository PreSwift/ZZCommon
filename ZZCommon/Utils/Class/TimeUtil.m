//
//  TimeUtil.m

//  Created by westMac on 2021/8/21.
//

#import "TimeUtil.h"

@implementation TimeUtil

/**
 根据日期获取时间字符串
 输出格式：yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)formatTimeFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

/**
 根据时间字符串获取日期
 dateStr：格式yyyy-MM-dd HH:mm:ss
 */
+ (NSDate *)formatTimeFromDateStr:(NSString *)dateStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter dateFromString:dateStr];
}

/**
 根据秒数获取时钟字符串
 输出格式：15:56:03表示15小时56分3秒
 */
+ (NSString *)formatTimeStrFromSecond: (NSUInteger)seconds {
    //format of hour
    NSInteger hour = seconds/3600;
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",hour];
    //format of minute
    NSInteger minute = (seconds%3600)/60;
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",minute];
    //format of second
    NSInteger leftSecond = seconds%60;
    NSString *str_second = [NSString stringWithFormat:@"%02ld",leftSecond];
    //format of time
    NSString *format_time;
    if (hour > 0) {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    } else {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }
    return format_time;
}

/**
 根据时间全字符串获取日期
 timeStr：格式yyyy-MM-dd HH:mm:ss 输出格式yyyy-MM-dd
 */
+ (NSString *)getJustDateFromFullDateStr:(NSString *)dateStr {
    NSArray<NSString *> *strs = [dateStr componentsSeparatedByString:@" "];
    if (strs.count >= 1) {
        return strs[0];
    }
    return nil;
}

/**
 根据时间全字符串获取不显示秒数的字符串
 输出格式：yyyy-MM-dd HH:mm
 */
+ (NSString *)getNoSecondTimeFromFullDateStr:(NSString *)dateStr {
    NSArray<NSString *> *strs = [dateStr componentsSeparatedByString:@":"];
    if (strs.count >= 2) {
        return [NSString stringWithFormat:@"%@:%@", strs[0], strs[1]];
    }
    return nil;
}

@end
