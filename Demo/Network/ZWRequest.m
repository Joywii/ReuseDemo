//
//  ZWRequest.m
//  Demo
//
//  Created by joywii on 14-9-2.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWRequest.h"
#import "HTTPUtil.h"


/*
 ****************************************ZWRequest**************************************
 */
@interface ZWRequest()

@property (nonatomic, strong) AFHTTPRequestOperation *httpRequestOperation;

/*
 *@Override
 */
- (ZWRequestResultData *)dealWithResultDictionary:(NSDictionary *)result;

@end

@implementation ZWRequest

- (instancetype)initGetWithURL:(NSString *)url
              params:(NSDictionary *)params
    httpHeaderFields:(NSDictionary *)httpHeaderFields
            delegate:(id)delegate
        requestBlock:(ZWRequestCompletionBlock)block
{
    return [self initWithURL:url
                  httpMethod:@"GET"
                      params:params
                  dataParams:nil
            httpHeaderFields:httpHeaderFields
                    delegate:delegate
                requestBlock:block];
}
- (instancetype)initPostWithURL:(NSString *)url
               params:(NSDictionary *)params
           dataParams:(NSDictionary *)dataParams
     httpHeaderFields:(NSDictionary *)httpHeaderFields
             delegate:(id)delegate
         requestBlock:(ZWRequestCompletionBlock)block
{
    return [self initWithURL:url
                  httpMethod:@"POST"
                      params:params
                  dataParams:dataParams
            httpHeaderFields:httpHeaderFields
                    delegate:delegate
                requestBlock:block];
}

- (instancetype)initWithURL:(NSString *)url
       httpMethod:(NSString *)httpMethod
           params:(NSDictionary *)params
       dataParams:(NSDictionary *)dataParams
 httpHeaderFields:(NSDictionary *)httpHeaderFields
         delegate:(id)delegate
     requestBlock:(ZWRequestCompletionBlock)block
{
    self = [super init];
    if(self)
    {
        self.url = url;
        self.httpMethod = httpMethod;
        self.params = params;
        self.httpHeaderFields = httpHeaderFields;
        self.requestBlock = block;
        self.dataParams = dataParams;
        self.delegate = delegate;
        
        _requestOperationManager = [AFHTTPRequestOperationManager manager];
        _requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _requestState = [[ZWRequestState alloc] init];
    }
    return self ;
}

- (void)startRequest
{
    [self.requestState reset];
    NSString *requestURLString = [HTTPUtil serializeURL:self.url params:self.params httpMethod:self.httpMethod];
    if (self.httpHeaderFields)
    {
        for(id key in self.httpHeaderFields.allKeys)
        {
            [self.requestOperationManager.requestSerializer setValue:[self.httpHeaderFields objectForKey:key]
                                                  forHTTPHeaderField:key];
        }
    }
    void (^successBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self successWithOperation:operation responseObject:responseObject];
    };
    void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self failureWithOperation:operation Error:error];
    };
    if ([self.httpMethod isEqualToString:@"GET"])
    {
        self.httpRequestOperation = [self.requestOperationManager GET:requestURLString
                                                           parameters:self.params
                                                              success:successBlock
                                                              failure:failureBlock];
    }
    else if([self.httpMethod isEqualToString:@"POST"])
    {
        void (^formBlock)(id<AFMultipartFormData> formData) = ^(id<AFMultipartFormData> formData)
        {
            if (self.dataParams)
            {
                //图片类型文件
                for(int i = 0 ; i < [self.dataParams.allKeys count] ; i++)
                {
                    [formData appendPartWithFileData:[_dataParams objectForKey:_dataParams.allKeys[i]]
                                                name:@"img"
                                            fileName:@"img.jpg"
                                            mimeType:@"image/jpeg"];
                }
                //其他文件类型
            }
        };
        self.httpRequestOperation = [self.requestOperationManager POST:requestURLString
                                                            parameters:self.params
                                             constructingBodyWithBlock:formBlock
                                                               success:successBlock
                                                               failure:failureBlock];
    }
    else if([self.httpMethod isEqualToString:@"PUT"])
    {
        self.httpRequestOperation = [self.requestOperationManager PUT:requestURLString
                                                           parameters:self.params
                                                              success:successBlock
                                                              failure:failureBlock];
    }
    else if([self.httpMethod isEqualToString:@"DELETE"])
    {
        self.httpRequestOperation = [self.requestOperationManager DELETE:requestURLString
                                                              parameters:self.params
                                                                 success:successBlock
                                                                 failure:failureBlock];
    }
    else
    {
        NSLog(@"no http method");
    }
}
- (void)stopRequest
{
    self.requestState.stateType = ZWRequestStateTypeCanceled;
    [self.httpRequestOperation cancel];
    [self finishRequest];
}
- (BOOL)isExecuting
{
    if(self.httpRequestOperation)
    {
        return [self.httpRequestOperation isExecuting] ;
    }
    return NO ;
}
/*
 *@Override
 */
- (ZWRequestResultData *)dealWithResultDictionary:(NSDictionary *)result
{
    return [[ZWRequestResultData alloc] init];
}
-(void)successWithOperation:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject
{
    id responseResult = nil;
    if([responseObject isKindOfClass:[NSData class]])
    {
        NSError *jsonerror = nil;
        responseResult = [NSJSONSerialization JSONObjectWithData:responseObject
                                                        options:NSJSONReadingMutableLeaves
                                                          error:&jsonerror];
        if(jsonerror)
        {
            [self failureWithOperation:operation Error:jsonerror];
            return;
        }
    }
    else
    {
        responseResult = responseObject;
    }
    ZWRequestResultData *responseData = [self dealWithResultDictionary:(NSDictionary *)responseResult];
    self.requestState.result = responseData;
    self.requestState.stateType = ZWRequestStateTypeSuccessed;
    self.requestState.stateCode = operation.response.statusCode;
    [self finishRequest];
}

- (void)failureWithOperation:(AFHTTPRequestOperation *)operation Error:(NSError *)error
{
    self.requestState.stateType = ZWRequestStateTypeFailed;
    self.requestState.stateCode = operation.response.statusCode;
    self.requestState.error = error;
    [self finishRequest];
}
- (void)finishRequest
{
    if (self.delegate && [_delegate respondsToSelector:@selector(request:state:)])
    {
        [self.delegate request:self state:self.requestState];
    }
    if (self.requestBlock)
    {
        self.requestBlock(self.requestState);
    }
}
@end

/*
 *************************************ZWRequestState************************************
 */
@implementation ZWRequestState

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    if(coder)
    {
    }
}
- (void)reset
{
    self.error  = nil;
    self.result = nil;
    _stateType  = ZWRequestStateTypeNone;
}
- (id)init
{
    if (self = [super init])
    {
        [self reset];
    }
    return self;
}
-(void)setResult:(ZWRequestResultData *)result
{
    if (result)
    {
        _stateType = ZWRequestStateTypeSuccessed;
        if (_result != result)
        {
            _result = result ;
        }
    }
}
-(void)setError:(NSError *)error
{
    if (error)
    {
        if (_error != error)
        {
            _error = error ;
        }
    }
}
@end
