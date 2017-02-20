//
//  DDPageManager.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDPageRouterProtocol <NSObject>

@required
- (void)setupPageQueryDic:(NSDictionary *)queryDic;

@end


@interface DDPageManager : NSObject

@property (nonatomic, weak) UINavigationController *currentTopNavigationController;

+ (instancetype)sharedManager;

- (void)setupPageMapping;

- (id)openUrl:(NSString *)url;

/**
 @return controller instance that binded with url
 */
- (id)openUrl:(NSString *)url withQueryData:(NSDictionary *)queryData;

- (id)instanceObjForUrl:(NSString *)url withQueryData:(NSDictionary *)queryData;

@end
