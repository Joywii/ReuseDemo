//
//  ZWResponseData.h
//  Demo
//
//  Created by joywii on 14-9-2.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求参数
@interface KZRequestParamsData : NSObject

-(NSDictionary *)requestDictionary;

@end

// 请求头数据
@interface ZWRequestHeaderData : NSObject

-(NSDictionary *)headerDictionary;

@end

//请求返回结果
@interface ZWRequestResultData : NSObject

@property (nonatomic, assign) int statusCode;

- (void)dispatchData:(NSDictionary *)result;

@end
