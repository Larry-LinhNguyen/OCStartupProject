//
//  DDPageMap.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDPageMetaInfo.h"

@interface DDPageMap : NSObject

+ (instancetype)defaultMap;
- (void)appendPageUrl:(NSString *)pageUrl withPageInfoObj:(DDPageMetaInfo *)pageInfoObj;
- (DDPageMetaInfo *)pageMetaInfoForPageUrl:(NSString *)pageUrl;

/// setup controller create from code
+ (DDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withPageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType;

/// setup controller create from nib
+ (DDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withNibName:(NSString *)nibName pageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType;

/// setup controller create from storyboard
+ (DDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withStoryboardName:(NSString *)storyboardName idString:(NSString *)idString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType;

@end
