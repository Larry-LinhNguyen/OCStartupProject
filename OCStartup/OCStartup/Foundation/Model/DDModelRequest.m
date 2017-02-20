//
//  DDModelRequest.m
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDModelRequest.h"
#import "DDNetworkManager.h"
#import "NSURLSessionTask+ddframework.h"

@implementation DDModelRequest {
    SEL _httpMethod;
}

- (DDModelRequest *)get {
    _httpMethod = _cmd;
    
    if ([DDNetworkManager hasNetwork]) {
        _isFired = YES;
        self.sessionTask = [[DDNetworkManager sharedManager] getRequestWithParams:self.params apiURl:self.apiUrlString completeHandler:self.uiCallback successAFCallback:^(id operationObj, id responseObject) {
            if ([operationObj isKindOfClass:[NSURLSessionTask class]]) {
                DDModelRequest *req = [(NSURLSessionTask *)operationObj getModelRequest];
                if (req.successCallback) {
                    req.successCallback(req, responseObject);
                }
            }
        } failAFCallback:^(id operation, NSError *error) {
            if ([operation isKindOfClass:[NSURLSessionTask class]]) {
                DDModelRequest *req = [(NSURLSessionTask *)operation getModelRequest];
                if (req.failCallback) {
                    req.failCallback(req, error);
                }
            }
        }];
        
        [self.sessionTask setModelRequest:self];
    }
    
    return self;
}

- (DDModelRequest *)post {
    _httpMethod = _cmd;
    
    if ([DDNetworkManager hasNetwork]) {
        _isFired = YES;
        self.sessionTask = [[DDNetworkManager sharedManager] postRequestWithParams:self.params apiURl:self.apiUrlString completeHandler:self.uiCallback successAFCallback:^(id operationObj, id responseObject) {
            if ([operationObj isKindOfClass:[NSURLSessionTask class]]) {
                DDModelRequest *req = [(NSURLSessionTask *)operationObj getModelRequest];
                if (req.successCallback) {
                    req.successCallback(req, responseObject);
                }
            }
        } failAFCallback:^(id operation, NSError *error) {
            if ([operation isKindOfClass:[NSURLSessionTask class]]) {
                DDModelRequest *req = [(NSURLSessionTask *)operation getModelRequest];
                if (req.failCallback) {
                    req.failCallback(req, error);
                }
            }
        }];
        
        [self.sessionTask setModelRequest:self];
    }
    
    return self;
}

- (DDModelRequest *)cancel {
    if (self.sessionTask) {
        [self.sessionTask setUICallback:NULL];
        [self.sessionTask cancel];
    }
    return self;
}

- (DDModelRequest *)retry {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (_httpMethod) {
        [self performSelector:_httpMethod];
    }
#pragma clang diagnostic pop

    return self;
}

@end
