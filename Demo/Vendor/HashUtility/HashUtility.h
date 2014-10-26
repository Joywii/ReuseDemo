//
//  HashUtility.h
//  youwo
//
//  Created by robbie on 13-9-26.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    THHashKindMd5,
    THHashKindSha1,
    THHashKindSha256,
    THHashKindSha512,
};
typedef NSInteger THHashKind;

@interface HashUtility : NSObject

//Hash 算法
+ (NSString *)hashFile:(NSString *)filePath with:(THHashKind)hashKind;
+ (NSString *)hashData:(NSData *)data with:(THHashKind)hashKind;
+ (NSString *)hashString:(NSString *)string with:(THHashKind)hashKind;

//HMAC 算法 (keyed-Hash Message Authentication Code,密钥相关的哈希运算消息认证码)
+ (NSString *)hMacData:(NSData *)data withSecretKey:(NSString *)secretKey withHashKind:(THHashKind)hashKind;
+ (NSString *)hMacString:(NSString *)string withSecretKey:(NSString *)secretKey withHashKind:(THHashKind)hashKind;

@end
