//
//  NSString+AES.h
//  jzjx
//
//  Created by west007 on 2021/7/12.
//


#import <Foundation/Foundation.h>

@interface NSString (AES)

/**< 加密方法 */
- (NSString*)aci_encryptWithAES;

/**< 解密方法 */
- (NSString*)aci_decryptWithAES;

@end

