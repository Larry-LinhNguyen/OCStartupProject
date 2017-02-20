//
//  DDUtility.h
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUtility : NSObject

+ (instancetype)sharedInstance;
- (void)appInitSetup;

/// 系统doc目录
+ (NSString *)documentDirString;

/// app version info
+ (NSString *)appVersionString;

@end
