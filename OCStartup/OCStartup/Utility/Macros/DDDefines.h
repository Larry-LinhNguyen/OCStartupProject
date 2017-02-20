//
//  DDDefines.h
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#ifndef DDDefines_h
#define DDDefines_h

#import <Foundation/Foundation.h>

typedef void(^ApiCompleteHandler)(NSError *error, id resultData, id pharsedData, id reqOpt);
typedef void(^RequestSuccessCallback)(id operationObj, id responseObject);
typedef void(^RequestFailCallback)(id operationObj, NSError *error);

extern NSString *const kNetworkResumeAviliableNotification;

#endif /* DDDefines_h */
