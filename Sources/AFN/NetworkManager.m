//
//  NetworkManager.m
//  213123
//
//  Created by liman on 15-1-7.
//  Copyright (c) 2015年 liman. All rights reserved.
//

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#import "NetworkManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@implementation NetworkManager

+ (NetworkManager *)sharedInstance
{
    static NetworkManager *__singletion = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion = [[self alloc] init];
    });
    return __singletion;
}


- (void)requestDataWithURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header cookies:(NSDictionary *)cookies timeoutInterval:(NSTimeInterval)timeoutInterval requestSerializer:(RequestSerializer)requestSerializer responseSerializer:(ResponseSerializer)responseSerializer result:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock
{
    //----------------------------------  GET ----------------------------------
    
    if ([method isEqualToString:@"GET"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式
        if (requestSerializer == HTTPRequestSerializer) {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        else if (requestSerializer == JSONRequestSerializer) {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
        }
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            if (header.count > 0) {
                for (NSString *key in [header allKeys]) {
                    [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
                }
            }
        }
        
        // 4.1 设置cookies
        if (cookies) {
            if (cookies.count > 0) {
                NSMutableArray *arr = [NSMutableArray array];
                for (NSString *key in [cookies allKeys]) {
                    NSString *str = [NSString stringWithFormat:@"%@=%@", key, [cookies objectForKey:key]];
                    [arr addObject:str];
                }
                
                NSString *string = [arr componentsJoinedByString:@";"];
                [manager.requestSerializer setValue:string forHTTPHeaderField:@"Cookie"];
            }
        }
        
        
        // 5.设置返回格式
        if (responseSerializer == HTTPResponseSerializer) {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
        else if (responseSerializer == JSONResponseSerializer) {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        
        // 6.请求
        if (parameter.count == 0) {
            parameter = nil;
        }
        [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            dispatch_main_async_safe(^{
                successBlock(responseObject);
            });
         
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            dispatch_main_async_safe(^{
                failureBlock(error);
            });
        }];
    }
    
    
    //----------------------------------  DELETE ----------------------------------
    
    if ([method isEqualToString:@"DELETE"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式
        if (requestSerializer == HTTPRequestSerializer) {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        else if (requestSerializer == JSONRequestSerializer) {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
        }
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            if (header.count > 0) {
                for (NSString *key in [header allKeys]) {
                    [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
                }
            }
        }
        
        
        // 5.设置返回格式
        if (responseSerializer == HTTPResponseSerializer) {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
        else if (responseSerializer == JSONResponseSerializer) {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        
        // 6.请求
        if (parameter.count == 0) {
            parameter = nil;
        }
        [manager DELETE:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            dispatch_main_async_safe(^{
                successBlock(responseObject);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            dispatch_main_async_safe(^{
                failureBlock(error);
            });
        }];
    }
    
    
    //----------------------------------  POST ----------------------------------
    
    if ([method isEqualToString:@"POST"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式
        if (requestSerializer == HTTPRequestSerializer) {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        else if (requestSerializer == JSONRequestSerializer) {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
        }
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            if (header.count > 0) {
                for (NSString *key in [header allKeys]) {
                    [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
                }
            }
        }
        
        
        // 5.设置返回格式
        if (responseSerializer == HTTPResponseSerializer) {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
        else if (responseSerializer == JSONResponseSerializer) {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        
        // 6.请求
        if (parameter.count == 0) {
            parameter = nil;
        }
        [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            dispatch_main_async_safe(^{
                successBlock(responseObject);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            dispatch_main_async_safe(^{
                failureBlock(error);
            });
        }];
    }
    
    
    //----------------------------------  PUT ----------------------------------
    
    if ([method isEqualToString:@"PUT"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式
        if (requestSerializer == HTTPRequestSerializer) {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        else if (requestSerializer == JSONRequestSerializer) {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
        }
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            if (header.count > 0) {
                for (NSString *key in [header allKeys]) {
                    [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
                }
            }
        }
        
        
        // 5.设置返回格式 
        if (responseSerializer == HTTPResponseSerializer) {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
        else if (responseSerializer == JSONResponseSerializer) {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        
        // 6.请求
        if (parameter.count == 0) {
            parameter = nil;
        }
        [manager PUT:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            dispatch_main_async_safe(^{
                successBlock(responseObject);
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            dispatch_main_async_safe(^{
                failureBlock(error);
            });
        }];
    }
}

@end
