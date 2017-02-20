//
//  DDBaseController.h
//  OCStartup
//
//  Created by Yanchen Wang on 17/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPageManager.h"
#import "DDGlobal.h"

@interface DDBaseController : UIViewController<DDPageRouterProtocol>

@property (nonatomic, weak) id currentPageRequestObj;
@property (nonatomic, strong) NSDictionary *pageQueryData;
@property (nonatomic, assign) BOOL shouldHideNavigationBar;
@property (nonatomic, readonly) BOOL isViewAppeared;

+ (instancetype)controllerLoadFromXib;

- (void)cancelRequestWhenDisappear;

// 添加notifiation通知方法 便于统一移除
- (id)dd_addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *note))block;

@end
