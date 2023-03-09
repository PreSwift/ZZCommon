//
//  NSString+AES.m
//  jzjx
//
//  Created by west007 on 2021/7/12.
//

#import "NSString+AES.h"
#import "MIUAES.h"

// key跟后台协商一个即可，保持一致
static NSString *const PSW_AES_KEY = @"pigxpigxpigxpigx";
// 这里的偏移量也需要跟后台一致，一般跟key一样就行
static NSString *const AES_IV_PARAMETER = @"pigxpigxpigxpigx";

@implementation NSString (AES)

- (NSString*)aci_encryptWithAES {
    return [MIUAES MIUAESEncrypt:self mode:MIUModeCFB key:PSW_AES_KEY keySize:MIUKeySizeAES128 iv:AES_IV_PARAMETER padding:MIUCryptorNoPadding];
}

- (NSString*)aci_decryptWithAES {
    return [MIUAES MIUAESDecrypt:self mode:MIUModeCFB key:PSW_AES_KEY keySize:MIUKeySizeAES128 iv:AES_IV_PARAMETER padding:MIUCryptorNoPadding];
}

@end
