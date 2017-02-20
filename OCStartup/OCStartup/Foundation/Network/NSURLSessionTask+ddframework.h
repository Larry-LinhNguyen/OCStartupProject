//
//  NSURLSessionTask+ddframework.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDDefines.h"
#import "DDModelRequest.h"

@interface NSURLSessionTask (ddframework)

- (ApiCompleteHandler)getUICallback;
- (void)setUICallback:(ApiCompleteHandler)handler;

- (void)setModelRequest:(DDModelRequest *)request;
- (DDModelRequest *)getModelRequest;

@end
