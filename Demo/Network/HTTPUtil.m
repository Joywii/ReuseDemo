//
//  HTTPUtil.m
//  ChangyanSDK
//
//  Created by 仲 维涛 on 14-1-20.
//  Copyright (c) 2014年 kingzwt. All rights reserved.
//

#import "HTTPUtil.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation HTTPUtil

+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSArray *pairs = [queryString componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs)
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if (elements.count == 2)
        {
            NSString *key = elements[0];
            NSString *value = elements[1];
            
            [dictionary setObject:value forKey:key];
        }
        if (elements.count == 1)
        {
            NSString *key = elements[0];
            [dictionary setObject:@"" forKey:key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:dictionary];
}
+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params httpMethod:(NSString *)httpMethod
{
    if (![httpMethod isEqualToString:@"GET"])
    {
        return baseURL;
    }
    NSURL *parsedURL = [NSURL URLWithString:baseURL];
	NSString *queryPrefix = parsedURL.query ? @"&" : @"?";
	NSString *query = [self stringFromDictionary:params];
	return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}
+ (NSString *)stringFromDictionary:(NSDictionary *)dict
{
    NSMutableArray *pairs = [NSMutableArray array];
	for (NSString *key in [dict keyEnumerator])
	{
        id value = [dict valueForKey:key];
		if (!([value isKindOfClass:[NSString class]]))
		{
            continue;
		}
        NSString *finalString = [self encodeToPercentEscapeString:(NSString *)value];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key,finalString]];
	}
	return [pairs componentsJoinedByString:@"&"];
}
+ (NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)input,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8));
    return outputStr;
}
@end
