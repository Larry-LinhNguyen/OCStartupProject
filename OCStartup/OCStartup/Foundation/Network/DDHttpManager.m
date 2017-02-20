//
//  DDHttpManager.m
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDHttpManager.h"
#import "AFNetworking.h"
#import "NSURLSessionTask+ddframework.h"

@interface DDHttpManager (){
    dispatch_queue_t _dataProcessQueue;
}

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

@end

@implementation DDHttpManager

+ (instancetype)sharedManager {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (AFHTTPSessionManager *)httpManager {
    if (!_httpManager) {
        _httpManager = [AFHTTPSessionManager manager];
        _httpManager.completionQueue = [self dataProcQueue];
    }
    return _httpManager;
}

- (dispatch_queue_t)dataProcQueue {
    if (!_dataProcessQueue) {
        _dataProcessQueue = dispatch_queue_create("com.ddframework.dataprocq", DISPATCH_QUEUE_SERIAL);
    }
    return _dataProcessQueue;
}

- (NSURLSessionTask *)getRequestWithParams:(NSDictionary *)params
                                    apiURl:(NSString *)apiUrl
                           completeHandler:(ApiCompleteHandler)handler
                         successAFCallback:(void (^)(id, id))success
                            failAFCallback:(void (^)(id, NSError *))fail {
    NSURLSessionTask *task = nil;
    
    task = [self.httpManager GET:apiUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        // do nothing
    } success:success failure:fail];
    [task setUICallback:handler];
    
    return task;
}

- (NSURLSessionTask *)postRequestWithParams:(NSDictionary *)params
                                     apiURl:(NSString *)apiUrl
                            completeHandler:(ApiCompleteHandler)handler
                          successAFCallback:(void (^)(id, id))success
                             failAFCallback:(void (^)(id, NSError *))fail {
    NSURLSessionTask *task = nil;
    
    task = [self.httpManager POST:apiUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        // do nothing
    } success:success failure:fail];
    [task setUICallback:handler];
    
    return task;
}

@end
