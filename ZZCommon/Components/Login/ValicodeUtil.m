//
//  ValicodeUtil.m
//  teacher
//
//  Created by westMac on 2021/9/9.
//

#import "ValicodeUtil.h"

@implementation ValicodeUtil

+ (void)sendValicode:(NSString *)phone userId:(NSString *)userId callback:(ValicodeCallback)callback{
    [[[ComApiHelper new] sendsmscode:phone userId:userId == nil ? [NSString stringWithFormat:@"%lu", [ComUserHelper shareInstance].userInfo.employeeId]: userId] startWithSuccess:^(YTKBaseRequest * _Nonnull request, ResponseModel * _Nullable responseModel) {
        [CountdownTimer startTimerWithKey:ValicodeCountdownTimer count:ValicodeCountDownSeconds callBack:^(NSInteger count, BOOL isFinished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNameValicodeCountDown object:[NSNumber numberWithInteger:count]];
        }];
        callback(0, nil);
    } failure:^(YTKBaseRequest * _Nonnull request, ResponseModel * _Nullable responseModel) {
        callback(responseModel.code, responseModel.msg);
    }];
}

+ (void)sendRegistValicode:(NSString *)phone userId:(NSString *)userId callback:(ValicodeCallback)callback{
    [[[ComApiHelper new] sendRegistSmscode:phone userId:userId] startWithSuccess:^(YTKBaseRequest * _Nonnull request, ResponseModel * _Nullable responseModel) {
        [CountdownTimer startTimerWithKey:ValicodeCountdownTimer count:ValicodeCountDownSeconds callBack:^(NSInteger count, BOOL isFinished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNameValicodeCountDown object:[NSNumber numberWithInteger:count]];
        }];
        callback(0, nil);
    } failure:^(YTKBaseRequest * _Nonnull request, ResponseModel * _Nullable responseModel) {
        callback(responseModel.code, responseModel.msg);
    }];
}

@end
