//
//  ZWDemoRequest.m
//  Demo
//
//  Created by joywii on 14-9-3.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWDemoRequest.h"

//请求本身
@implementation ZWDemoRequest

- (ZWRequestResultData *)dealWithResultDictionary:(NSDictionary *)result
{
    ZWDemoRequestResultData *requestResult = [[ZWDemoRequestResultData alloc] init];
    [requestResult dispatchData:result];
    return requestResult;
}

@end

//请求参数
@implementation ZWDemoRequestParamsData

-(id)init
{
    if (self = [super init])
    {
    }
    return self;
}

-(NSDictionary *)requestDictionary
{
    return nil;
}

@end

//请求结果
@implementation ZWDemoRequestResultData
- (void)dispatchData:(NSDictionary *)result
{
    [super dispatchData:result];
    NSLog(@"%@",result);
}

@end