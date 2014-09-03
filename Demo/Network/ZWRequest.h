//
//  ZWRequest.h
//  Demo
//
//  Created by joywii on 14-9-2.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWResquestData.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"

@class ZWRequest;
@class ZWRequestState;
//Delegate 回调
@protocol ZWRequestDelegate <NSObject>

@optional
- (void)request:(ZWRequest*)request state:(ZWRequestState *)state;

@end

//Block 回调
typedef void(^ZWRequestCompletionBlock)(ZWRequestState *state);

//请求结果状态
typedef enum ZWRequestStateType
{
    ZWRequestStateTypeNone = 0,
    ZWRequestStateTypeFailed,
    ZWRequestStateTypeSuccessed,
    ZWRequestStateTypeCanceled
}ZWRequestStateType;

/*
 *************************************ZWRequestState************************************
 */
@interface ZWRequestState : NSObject

@property (nonatomic, strong) NSError               *error;
@property (nonatomic, strong) ZWRequestResultData   *result;
@property (nonatomic, strong) NSDictionary          *responseHeaders;
@property (nonatomic, assign) ZWRequestStateType    stateType;
@property (nonatomic, assign) NSInteger             stateCode;

- (void)reset;

@end

/*
 ****************************************ZWRequest**************************************
 */
@interface ZWRequest : NSObject

@property (nonatomic, strong) NSString                       *url;
@property (nonatomic, strong) NSString                       *httpMethod;
@property (nonatomic, strong) NSDictionary                   *params;
@property (nonatomic, strong) NSDictionary                   *dataParams;
@property (nonatomic, strong) NSDictionary                   *httpHeaderFields;
@property (nonatomic, copy)   ZWRequestCompletionBlock       requestBlock;
@property (nonatomic, strong, readonly) ZWRequestState       *requestState;
@property (nonatomic, weak) id<ZWRequestDelegate>            delegate;

@property (nonatomic, strong) AFHTTPRequestOperationManager  *requestOperationManager;
@property (nonatomic, strong) AFURLSessionManager            *requestSessionManager;

- (instancetype)initGetWithURL:(NSString *)url
                        params:(NSDictionary *)params
              httpHeaderFields:(NSDictionary *)httpHeaderFields
                      delegate:(id)delegate
                  requestBlock:(ZWRequestCompletionBlock)block;

- (instancetype)initPostWithURL:(NSString *)url
                         params:(NSDictionary *)params
                     dataParams:(NSDictionary *)dataParams
               httpHeaderFields:(NSDictionary *)httpHeaderFields
                       delegate:(id)delegate
                   requestBlock:(ZWRequestCompletionBlock)block;

- (instancetype)initWithURL:(NSString *)url
                 httpMethod:(NSString *)httpMethod
                     params:(NSDictionary *)params
                 dataParams:(NSDictionary *)dataParams
           httpHeaderFields:(NSDictionary *)httpHeaderFields
                   delegate:(id)delegate
               requestBlock:(ZWRequestCompletionBlock)block;

- (void)startRequest;

- (void)stopRequest;

- (BOOL)isExecuting;

@end
