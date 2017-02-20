//
//  DDNetwork.m
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDNetwork.h"
#import "AFNetworkReachabilityManager.h"
#import "DDModelRequest.h"

NSString *const kNetworkResumeAviliableNotification = @"kNetworkResumeAviliableNotification";

@implementation DDNetwork

+ (void)load {
    __weak id obser = nil;
    obser = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [[self sharedInstance] startNetworkAviliableNotifier];
        [[NSNotificationCenter defaultCenter] removeObserver:obser];
    }];
}

+ (instancetype)sharedInstance {
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

- (void)cancelRequestWithRequestObject:(id)reqObj {
    if ([reqObj isKindOfClass:[DDModelRequest class]]) {
        [(DDModelRequest *)reqObj cancel];
    }
}

+ (BOOL)hasNetwork {
    return [[self sharedInstance] isNetworkAviliable];
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

@end
