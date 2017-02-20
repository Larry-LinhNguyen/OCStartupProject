//
//  DDPageMetaInfo.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PageOpenType) {
    PageOpenTypePush,
    PageOpenTypeModal,
};

typedef NS_ENUM(NSUInteger, PageCacheType) {
    PageCacheTypeNormal, // 普通页面，不缓存
    PageCacheTypeShared, // 共享页面，创建后一直缓存
};

typedef NS_ENUM(NSUInteger, PageSourceType) {
    PageSourceTypeStoryboard,
    PageSourceTypeNib,
    PageSourceTypeCode,
};

@interface DDPageMetaInfo : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *pageUrlString;

@property (nonatomic, assign) PageOpenType openType;
@property (nonatomic, assign) PageCacheType cacheType;
@property (nonatomic, assign) PageSourceType sourceType;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) BOOL shouldContainController;

@property (nonatomic, copy) NSString *pageClassNameString;
@property (nonatomic, copy) NSString *pageStoryboardName; // default main
@property (nonatomic, copy) NSString *pageNibName;

@property (nonatomic, strong) id cachedPageInstance;

@end
