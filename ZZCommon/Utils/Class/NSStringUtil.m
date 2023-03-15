//
//  NSStringUtil.m

//  Created by westMac on 2021/9/2.
//

#import "NSStringUtil.h"

@implementation NSStringUtil

+ (NSString *)formatCount:(NSInteger)count {
    if (count >= 10000) {
        return [NSString stringWithFormat:@"%ld万", (count / 10000)];
    }
    return [NSString stringWithFormat:@"%ld", count];
}

+ (NSString *)showScore:(CGFloat)score {
    if (score == -1) {
        return @"--";
    } else {
        return [self formatFloatNumber:score];
    }
}

+ (NSString *)formatFloatNumber:(CGFloat)score {
    if (score == 0) {
        return @"0";
    } else if (score == (int)score) {
        return [NSString stringWithFormat:@"%d", (int)score];
    } else {
        CGFloat roundFScore = roundf(score*100)/100;
        NSString *scoreStr = [NSNumber numberWithFloat:roundFScore].stringValue;
        if ([scoreStr containsString:@"."]) {
            NSRange range = [scoreStr rangeOfString:@"."];
            if (scoreStr.length - range.location - 1 > 2) {
                return [scoreStr substringToIndex:range.location + 3];
            } else {
                return scoreStr;
            }
        } else {
            return scoreStr;
        }
    }
}


/**
 *  将阿拉伯数字转换为中文数字
 */
+(NSString *)translationArabicNum:(NSInteger)arabicNum
{
    NSString *arabicNumStr = [NSString stringWithFormat:@"%ld",(long)arabicNum];
    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chineseNumeralsArray forKeys:arabicNumeralsArray];
    
    if (arabicNum < 20 && arabicNum > 9) {
        if (arabicNum == 10) {
            return @"十";
        }else{
            NSString *subStr1 = [arabicNumStr substringWithRange:NSMakeRange(1, 1)];
            NSString *a1 = [dictionary objectForKey:subStr1];
            NSString *chinese1 = [NSString stringWithFormat:@"十%@",a1];
            return chinese1;
        }
    }else{
        NSMutableArray *sums = [NSMutableArray array];
        for (int i = 0; i < arabicNumStr.length; i ++)
        {
            NSString *substr = [arabicNumStr substringWithRange:NSMakeRange(i, 1)];
            NSString *a = [dictionary objectForKey:substr];
            NSString *b = digits[arabicNumStr.length -i-1];
            NSString *sum = [a stringByAppendingString:b];
            if ([a isEqualToString:chineseNumeralsArray[9]])
            {
                if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
                {
                    sum = b;
                    if ([[sums lastObject] isEqualToString:chineseNumeralsArray[9]])
                    {
                        [sums removeLastObject];
                    }
                }else
                {
                    sum = chineseNumeralsArray[9];
                }
                
                if ([[sums lastObject] isEqualToString:sum])
                {
                    continue;
                }
            }
            
            [sums addObject:sum];
        }
        NSString *sumStr = [sums  componentsJoinedByString:@""];
        NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
        return chinese;
    }
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3456789]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber] && telNumber.length == 11;
    return isMatch;
}


#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

+ (NSString *)checkNull:(NSString *)showStr {
    return showStr ? showStr : @"";
}

+ (NSString *)checkNull:(NSString *)showStr placeholder:(NSString *)placeholder {
    return showStr && showStr.length > 0 ? showStr : (placeholder ? placeholder : @"");
}

+ (NSString *)addTimestamp:(NSString *)url {
    if (url) {
        NSString *newUrl;
        NSInteger timestamp = NSDate.new.timeIntervalSince1970;
        if ([url containsString:@"?"]) {
            newUrl = [NSString stringWithFormat:@"%@&%ld", url, timestamp];
        } else {
            newUrl = [NSString stringWithFormat:@"%@?%ld", url, timestamp];
        }
        return newUrl;
    }
    return nil;
}

/**
 *    去除字符串中连续换行，只保留结尾处换行
 *    allStr 字符串
 *    return 去除连续换行后的字符串
 */
+ (NSString *)trimAllNewline:(NSString *)allStr {
    if (allStr) {
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"\n{1,}" options:0 error:nil];
        NSString *newString = [regular stringByReplacingMatchesInString:allStr options:0 range:NSMakeRange(0, [allStr length]) withTemplate:@"\n"];
        return newString;
    }
    return nil;
}

@end
