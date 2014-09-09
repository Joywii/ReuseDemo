//
//  ZWShareData.m
//  Demo
//
//  Created by joywii on 14-9-9.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWShareData.h"

@implementation ZWShareData

+ (id)shareInstance
{
    static ZWShareData *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        if (instance == nil)
        {
            instance = [[ZWShareData alloc] init];
        }
    });
    return instance;
}

@end
