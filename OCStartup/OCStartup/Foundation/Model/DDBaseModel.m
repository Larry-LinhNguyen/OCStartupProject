//
//  DDBaseModel.m
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDBaseModel.h"

@implementation DDBaseModel

+ (instancetype)model {
    return [self new];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _apiHostUrl = @""; // todo:
    }
    return self;
}

- (RequestFailCallback)defaultFailureCallback {
    return ^(id operationObj, NSError *error) {
        if ([operationObj isKindOfClass:[DDModelRequest class]]) {
            DDModelRequest *req = operationObj;
            
            if (req.uiCallback) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    req.uiCallback(error, nil, nil, req);
                });
            }
        }
    };
}

- (RequestSuccessCallback)defaultSuccessCallback {
    WEAK_SELF_DEFINE(pSelf);
    return ^(id operationObj, id responseObject) {
        if ([operationObj isKindOfClass:[DDModelRequest class]]) {
            DDModelRequest *req = operationObj;
            NSError *error = nil;
            DDModelResponse *resp = [pSelf generateResponseWithResultData:responseObject error:&error];
            
            if (req.uiCallback) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    req.uiCallback(error, resp.dataObj, resp.pharsedDataObj, req);
                });
            }
        }
    };
}

- (DDModelResponse *)generateResponseWithResultData:(id)resultData error:(NSError *__autoreleasing *)errorPtr {
    DDModelResponse *resp = [[DDModelResponse alloc] initWithResultData:resultData];
    
    // todo: 根据具体情况判断
    if (resp.code < 0) {
        *errorPtr = resp.error;
    }
    
    return resp;
}

- (void)callbackUIBlockWithError:(NSError *)error resultData:(id)resultData pharsedData:(id)pharsedData operation:(id)operationObj {
    if ([operationObj isKindOfClass:[DDModelRequest class]]) {
        DDModelRequest *req = operationObj;
        
        if (req.uiCallback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                req.uiCallback(error, resultData, pharsedData, req);
            });
        }
    }
}

- (NSDictionary *)configureModelParams:(NSDictionary *)params {
    // todo:
    return params;
}

- (NSDictionary *)configureCommonParams:(NSDictionary *)params {
    // todo:
    return params;
}

- (DDModelRequest *)postRequestWithParams:(NSDictionary *)params
                                  apiPath:(NSString *)apiPath
                          completeHandler:(ApiCompleteHandler)handler
                        successAFCallback:(RequestSuccessCallback)success
                           failAFCallback:(RequestFailCallback)fail
                         startImmediately:(BOOL)immediatelyStart {
    
    params = [self configureModelParams:params];
    params = [self configureCommonParams:params];
    
    DDModelRequest *req = [DDModelRequest new];
    req.params = params;
    req.apiUrlString = [self.apiHostUrl stringByAppendingPathComponent:apiPath];
    req.uiCallback = handler;
    req.successCallback = success;
    req.failCallback = fail;
    
    return immediatelyStart ? [req post] : req;
}

- (DDModelRequest *)getRequestWitHParams:(NSDictionary *)params
                                 apiPath:(NSString *)apiPath
                         completeHandler:(ApiCompleteHandler)handler
                       successAFCallback:(RequestSuccessCallback)success
                          failAFCallback:(RequestFailCallback)fail
                        startImmediately:(BOOL)immediatelyStart {
    
    params = [self configureModelParams:params];
    params = [self configureCommonParams:params];
    
    DDModelRequest *req = [DDModelRequest new];
    req.params = params;
    req.apiUrlString = [self.apiHostUrl stringByAppendingPathComponent:apiPath];
    req.uiCallback = handler;
    req.successCallback = success;
    req.failCallback = fail;
    
    return immediatelyStart ? [req get] : req;
}

@end
