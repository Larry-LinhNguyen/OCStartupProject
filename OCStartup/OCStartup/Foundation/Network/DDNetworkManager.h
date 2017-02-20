//
//  DDNetworkManager.h
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDDefines.h"

@interface DDNetworkManager : NSObject

@property (readonly) BOOL isNetworkAviliable;

+ (instancetype)sharedManager;

+ (BOOL)hasNetwork;
- (void)startNetworkAviliableNotifier;

- (void)cancelRequestWithRequestObject:(id)reqObj;

// http methods
- (NSURLSessionTask *)getRequestWithParams:(NSDictionary *)params
                                    apiURl:(NSString *)apiUrl
                           completeHandler:(ApiCompleteHandler)handler
                         successAFCallback:(void (^)(id operationObj, id responseObject))success
                            failAFCallback:(void (^)(id operation, NSError *error))fail;

- (NSURLSessionTask *)postRequestWithParams:(NSDictionary *)params
                                     apiURl:(NSString *)apiUrl
                            completeHandler:(ApiCompleteHandler)handler
                          successAFCallback:(void (^)(id operationObj, id responseObject))success
                             failAFCallback:(void (^)(id operation, NSError *error))fail;


@end
