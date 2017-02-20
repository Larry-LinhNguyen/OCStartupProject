//
//  DDPageManager.m
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDPageManager.h"
#import "DDPageMap.h"
#import "DDGlobal.h"

@interface DDPageManager ()

@property (nonatomic, strong) DDPageMap *pageMap;

@end

@implementation DDPageManager

+ (instancetype)sharedManager {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (void)setupPageMapping {
    // todo : init page mapping
}

- (id)openUrl:(NSString *)url {
    return [self openUrl:url withQueryData:nil];
}

- (id)openUrl:(NSString *)url withQueryData:(NSDictionary *)queryData {
    if (url.length > 0) {
        DDPageMetaInfo *pageObj = [self.pageMap pageMetaInfoForPageUrl:url];
        if (pageObj) {
            UIViewController *controller = nil;
            
            // load cache if needed
            if (pageObj.cacheType == PageCacheTypeShared) {
                controller = [pageObj.cachedPageInstance isKindOfClass:[UIViewController class]] ? pageObj.cachedPageInstance : nil;
                
                // 防止共享的已经展示了的controller重复打开导致问题
                if (controller.parentViewController || controller.presentingViewController) {
                    return nil;
                }
                
                // 如果controller加载过，view还在内存中，在打开时需要释放view 保证controller会重新调用viewDidLoad
                if (controller &&
                    controller.isViewLoaded) {
                    [controller.view removeFromSuperview];
                    controller.view = nil;
                }
            }
            
            if (!controller) {
                controller = [self generateControllerFromPageObj:pageObj];
            }
            
            if ([controller conformsToProtocol:@protocol(DDPageRouterProtocol)]) {
                [(id<DDPageRouterProtocol>)controller setupPageQueryDic:queryData];
            }
            
            if (controller) {
                if (pageObj.openType == PageOpenTypeModal) {
                    
                    if (pageObj.shouldContainController) {
                        if (![controller isKindOfClass:[UINavigationController class]]) {
                            controller = [[UINavigationController alloc] initWithRootViewController:controller];
                        }
                    }
                    
                    [self.currentTopNavigationController presentViewController:controller animated:pageObj.animated completion:^{
                        
                    }];
                    
                } else if (pageObj.openType == PageOpenTypePush) {
                    
                    if (![controller isKindOfClass:[UINavigationController class]]) {
                        [self.currentTopNavigationController pushViewController:controller animated:pageObj.animated];
                        
                        // 自定义返回按钮后  设置手势返回
                        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                            if ([self.currentTopNavigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                                self.currentTopNavigationController.interactivePopGestureRecognizer.delegate = nil;
                            }
                        }
                    }
                }
            }
            
            return controller;
        }
    }
    return nil;
}

- (id)instanceObjForUrl:(NSString *)url withQueryData:(NSDictionary *)queryData {
    if (url.length > 0) {
        DDPageMetaInfo *pageObj = [self.pageMap pageMetaInfoForPageUrl:url];
        if (pageObj) {
            UIViewController *controller = nil;
            
            // load cache if needed
            if (pageObj.cacheType == PageCacheTypeShared) {
                controller = [pageObj.cachedPageInstance isKindOfClass:[UIViewController class]] ? pageObj.cachedPageInstance : nil;
                
                // 防止共享的已经展示了的controller重复打开导致问题
                if (controller.parentViewController || controller.presentingViewController) {
                    return nil;
                }
                
                // 如果controller加载过，view还在内存中，在打开时需要释放view 保证controller会重新调用viewDidLoad
                if (controller &&
                    controller.isViewLoaded) {
                    [controller.view removeFromSuperview];
                    controller.view = nil;
                }
            }
            
            if (!controller) {
                controller = [self generateControllerFromPageObj:pageObj];
            }
            
            if ([controller conformsToProtocol:@protocol(DDPageRouterProtocol)]) {
                [(id<DDPageRouterProtocol>)controller setupPageQueryDic:queryData];
            }
            
            return controller;
        }
    }
    
    return nil;
}

#pragma mark - properties
- (DDPageMap *)pageMap {
    if (!_pageMap) {
        _pageMap = [DDPageMap defaultMap];
    }
    return _pageMap;
}

#pragma mark - private
- (UIViewController *)generateControllerFromPageObj:(DDPageMetaInfo *)pageObj {
    if (pageObj && [pageObj isKindOfClass:[DDPageMetaInfo class]]) {
        UIViewController *controller = nil;
        
        if (pageObj.sourceType == PageSourceTypeCode) {
            if (pageObj.pageClassNameString.length > 0) {
                controller = [[NSClassFromString(pageObj.pageClassNameString) alloc] init];
            }
        } else if (pageObj.sourceType == PageSourceTypeNib) {
            if (pageObj.pageNibName.length > 0 && pageObj.pageClassNameString.length > 0 && [NSClassFromString(pageObj.pageClassNameString) isSubclassOfClass:[UIViewController class]]) {
                controller = [[NSClassFromString(pageObj.pageClassNameString) alloc] initWithNibName:pageObj.pageNibName bundle:nil];
            }
        } else if (pageObj.sourceType == PageSourceTypeStoryboard) {
            if (pageObj.identifier.length > 0) {
                UIStoryboard *sb = pageObj.pageStoryboardName.length > 0 ? [UIStoryboard storyboardWithName:pageObj.pageStoryboardName bundle:nil] : [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                controller = [sb instantiateViewControllerWithIdentifier:pageObj.identifier];
            }
        }
        
        if (pageObj.cacheType == PageCacheTypeShared) {
            pageObj.cachedPageInstance = controller;
        }
        
        return controller;
    }
    return nil;
}

@end
