//
//  DDPageMap.m
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "DDPageMap.h"
#import "DDGlobal.h"

@interface DDPageMap ()

@property (nonatomic, strong) NSMutableDictionary *pageCacheDic;

@end

@implementation DDPageMap

+ (instancetype)defaultMap {
    static id _s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _s_instance = [self new];
    });
    return _s_instance;
}

- (void)appendPageUrl:(NSString *)pageUrl withPageInfoObj:(DDPageMetaInfo *)pageInfoObj {
    if (pageUrl.length > 0 && [pageInfoObj isKindOfClass:[DDPageMetaInfo class]]) {
        [self.pageCacheDic setObject:pageInfoObj forKey:pageUrl];
    }
}

- (DDPageMetaInfo *)pageMetaInfoForPageUrl:(NSString *)pageUrl {
    if (pageUrl.length > 0) {
        return [self.pageCacheDic objectForKey:pageUrl ofClass:[DDPageMetaInfo class] defaultObj:nil];
    }
    return nil;
}

/// setup controller create from code
+ (DDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withPageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType {
    if (pageUrl.length > 0 && classString.length > 0) {
        
        DDPageMetaInfo *pageObj = [DDPageMetaInfo new];
        pageObj.pageUrlString = pageUrl;
        pageObj.pageClassNameString = classString;
        pageObj.openType = openType;
        pageObj.cacheType = cacheType;
        pageObj.sourceType = PageSourceTypeCode;
        pageObj.animated = YES;
        
        [[self defaultMap] appendPageUrl:pageUrl withPageInfoObj:pageObj];
        
        return pageObj;
    }
    return nil;
}

/// setup controller create from nib
+ (DDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withNibName:(NSString *)nibName pageClassString:(NSString *)classString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType {
    if (pageUrl.length > 0 && nibName.length > 0) {
        
        DDPageMetaInfo *pageObj = [DDPageMetaInfo new];
        pageObj.pageUrlString = pageUrl;
        pageObj.pageNibName = nibName.length > 0 ? nibName : classString;
        pageObj.pageClassNameString = classString.length > 0 ? classString : nibName;
        pageObj.openType = openType;
        pageObj.cacheType = cacheType;
        pageObj.sourceType = PageSourceTypeNib;
        pageObj.animated = YES;
        
        [[self defaultMap] appendPageUrl:pageUrl withPageInfoObj:pageObj];
        
        return pageObj;
    }
    return nil;
}

/// setup controller create from storyboard
+ (DDPageMetaInfo *)appendPageUrl:(NSString *)pageUrl withStoryboardName:(NSString *)storyboardName idString:(NSString *)idString openType:(PageOpenType)openType cacheType:(PageCacheType)cacheType {
    
    if (pageUrl.length > 0 && idString.length > 0) {
        
        DDPageMetaInfo *pageObj = [DDPageMetaInfo new];
        pageObj.pageUrlString = pageUrl;
        pageObj.pageStoryboardName = storyboardName;
        pageObj.identifier = idString;
        pageObj.openType = openType;
        pageObj.cacheType = cacheType;
        pageObj.sourceType = PageSourceTypeStoryboard;
        pageObj.animated = YES;
        
        [[self defaultMap] appendPageUrl:pageUrl withPageInfoObj:pageObj];
        
        return pageObj;
    }
    return nil;
}

#pragma mark - properties
- (NSMutableDictionary *)pageCacheDic {
    if (!_pageCacheDic) {
        _pageCacheDic = [[NSMutableDictionary alloc] init];
    }
    return _pageCacheDic;
}

@end
