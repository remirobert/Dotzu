//
//  NetworkManager.h
//  213123
//
//  Created by liman on 15-1-7.
//  Copyright (c) 2015年 liman. All rights reserved.
//

typedef enum _RequestSerializer {
    JSONRequestSerializer = 0,//JSON格式
    HTTPRequestSerializer = 1,//Form格式
} RequestSerializer;

typedef enum _ResponseSerializer {
    JSONResponseSerializer = 0,//JSON格式
    HTTPResponseSerializer = 1,//Form格式
} ResponseSerializer;

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (NetworkManager *)sharedInstance;

- (void)requestDataWithURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header cookies:(NSDictionary *)cookies timeoutInterval:(NSTimeInterval)timeoutInterval requestSerializer:(RequestSerializer)requestSerializer responseSerializer:(ResponseSerializer)responseSerializer result:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock;

@end
