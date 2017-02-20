//
//  DDNetworkManager.m
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDNetworkManager.h"
#import "AFNetworking.h"
#import "NSURLSessionTask+ddframework.h"
#import "DDModelRequest.h"

NSString *const kNetworkResumeAviliableNotification = @"kNetworkResumeAviliableNotification";

@interface DDNetworkManager (){
    dispatch_queue_t _dataProcessQueue;
}

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

@end

@implementation DDNetworkManager

+ (void)load {
    __weak id obser = nil;
    obser = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [[self sharedManager] startNetworkAviliableNotifier];
        [[NSNotificationCenter defaultCenter] removeObserver:obser];
    }];
}

+ (instancetype)sharedManager {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _isNetworkAviliable = YES;
    }
    return self;
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


- (void)cancelRequestWithRequestObject:(id)reqObj {
    if ([reqObj isKindOfClass:[DDModelRequest class]]) {
        [(DDModelRequest *)reqObj cancel];
    }
}

+ (BOOL)hasNetwork {
    return [[self sharedManager] isNetworkAviliable];
}

- (void)startNetworkAviliableNotifier {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable ||
            status == AFNetworkReachabilityStatusUnknown) {
            NSLog(@"network access lost !!");
            _isNetworkAviliable = NO;
        }
        else {
            NSLog(@"network access is ready isWAN %d isWifi %d", (status == AFNetworkReachabilityStatusReachableViaWWAN), (status == AFNetworkReachabilityStatusReachableViaWiFi));
            _isNetworkAviliable = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkResumeAviliableNotification object:nil];
            });
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
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
