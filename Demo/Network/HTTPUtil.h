//
//  HTTPUtil.h
//  ChangyanSDK
//
//  Created by joywii on 14-1-20.
//  Copyright (c) 2014年 joywii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPUtil : NSObject

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString;

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod;

+ (NSString *)stringFromDictionary:(NSDictionary *)dict;

@end
