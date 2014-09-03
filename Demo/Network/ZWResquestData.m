//
//  ZWResponseData.m
//  Demo
//
//  Created by joywii on 14-9-2.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWResquestData.h"

//请求参数
@implementation KZRequestParamsData : NSObject

/*
 *根据子类的属性生成NSDictionary
 */
-(NSDictionary *)requestDictionary
{
    return nil;
}

@end

//请求头数据
@implementation ZWRequestHeaderData : NSObject

/*
 *根据子类的属性生成NSDictionary
 */
-(NSDictionary *)headerDictionary
{
    return nil;
}

@end

//请求返回结果
@implementation ZWRequestResultData

/*
 *根据NSDictionary生成具体信息
 */
- (void)dispatchData:(NSDictionary *)result
{
    
}

@end
