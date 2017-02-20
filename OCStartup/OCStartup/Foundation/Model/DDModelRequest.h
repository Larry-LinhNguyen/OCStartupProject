//
//  DDModelRequest.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDDefines.h"

@interface DDModelRequest : NSObject

@property (nonatomic, assign, readonly) BOOL isFired;
@property (nonatomic, weak) NSURLSessionTask *sessionTask;

// request components
@property (nonatomic, copy) ApiCompleteHandler uiCallback;
@property (nonatomic, copy) RequestSuccessCallback successCallback;
@property (nonatomic, copy) RequestFailCallback failCallback;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, copy) NSString *apiUrlString;

- (DDModelRequest *)get;
- (DDModelRequest *)post;
- (DDModelRequest *)cancel;
- (DDModelRequest *)retry;

@end
