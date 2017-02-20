//
//  NSURLSessionTask+ddframework.m
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "NSURLSessionTask+ddframework.h"
#import <objc/runtime.h>

static const NSString *kUICallbackKey = @"kUICallbackKey";
static const NSString *kModelRequestkey = @"kModelRequestkey";

@implementation NSURLSessionTask (ddframework)

- (ApiCompleteHandler)getUICallback {
    return objc_getAssociatedObject(self, (__bridge const void *)(kUICallbackKey));
}

- (void)setUICallback:(ApiCompleteHandler)handler {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(kUICallbackKey),
                             handler,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setModelRequest:(DDModelRequest *)request {
    objc_setAssociatedObject(self,
                             (__bridge const void *)(kModelRequestkey),
                             request,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DDModelRequest *)getModelRequest {
    return objc_getAssociatedObject(self, (__bridge const void *)(kModelRequestkey));
}

@end
