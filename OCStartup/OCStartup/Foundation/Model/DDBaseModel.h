//
//  DDBaseModel.h
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDDefines.h"
#import "DDModelRequest.h"
#import "DDModelResponse.h"

@interface DDBaseModel : NSObject

@property (nonatomic, copy) NSString *apiHostUrl;

+ (instancetype)model; // default model config

- (DDModelResponse *)generateResponseWithResultData:(id)resultData error:(NSError **)errorPtr;
- (RequestFailCallback)defaultFailureCallback;
- (RequestSuccessCallback)defaultSuccessCallback;
- (void)callbackUIBlockWithError:(NSError *)error resultData:(id)resultData pharsedData:(id)pharsedData operation:(id)operationObj;

// override for subclass
- (NSDictionary *)configureModelParams:(NSDictionary *)params;
- (NSDictionary *)configureCommonParams:(NSDictionary *)params;

- (DDModelRequest *)postRequestWithParams:(NSDictionary *)params
                                  apiPath:(NSString *)apiPath
                          completeHandler:(ApiCompleteHandler)handler
                        successAFCallback:(RequestSuccessCallback)success
                           failAFCallback:(RequestFailCallback)fail
                         startImmediately:(BOOL)immediatelyStart;

- (DDModelRequest *)getRequestWitHParams:(NSDictionary *)params
                                 apiPath:(NSString *)apiPath
                         completeHandler:(ApiCompleteHandler)handler
                       successAFCallback:(RequestSuccessCallback)success
                          failAFCallback:(RequestFailCallback)fail
                        startImmediately:(BOOL)immediatelyStart;

@end
