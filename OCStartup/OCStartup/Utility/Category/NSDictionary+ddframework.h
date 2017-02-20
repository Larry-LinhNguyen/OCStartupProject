//
//  NSDictionary+ddframework.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef NS_ENUM(NSUInteger, DDDictionaryKeySortedType) {
    DDDictionaryKeySortedTypeAscending,
    DDDictionaryKeySortedTypeDescending,
};

@interface NSDictionary (ddframework)

- (id)objectForKey:(NSString *)key defalutObj:(id)defaultObj;
- (id)objectForKey:(id)aKey ofClass:(Class)aClass defaultObj:(id)defaultObj;
- (NSInteger)intValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;
- (CGFloat)floatValueForKey:(NSString *)key defaultValue:(CGFloat)defaultValue;
- (long)longValueForKey:(NSString *)key defaultValue:(long)defaultValue;
- (long long)longlongValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSArray *)arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSDictionary *)dictionaryValueForKey:(NSString *)key defalutValue:(NSDictionary *)defaultValue;

- (void)setRect:(CGRect)rect forKey:(NSString *)key;
- (CGRect)rectValueForKey:(NSString *)key;

- (NSArray *)sortedKeysWithOption:(DDDictionaryKeySortedType)type;
- (NSArray *)allValuesWithKeySortedOpetion:(DDDictionaryKeySortedType)type;
- (NSArray *)keyValueArrayWithSortOption:(DDDictionaryKeySortedType)sortType;

// 过滤NSNull
- (NSDictionary *)dictionaryWithoutNullValue;

@end
