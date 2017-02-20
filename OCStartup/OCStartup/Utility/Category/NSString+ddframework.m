//
//  NSString+ddframework.m
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import "NSString+ddframework.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ddframework)

- (BOOL)isValidateWithPredicstring:(NSString *)predicStr{
    NSPredicate *predic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicStr];
    return [predic evaluateWithObject:self];
}

- (BOOL)isValidEmail {
    if ([self length] == 0) {
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateWithPredicstring:emailRegex];
}

- (BOOL)isValidPhoneNumber {
    if ([self length] == 0) {
        return NO;
    }
    
    NSString *phoneNumberRegEx		= @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    return [self isValidateWithPredicstring:phoneNumberRegEx];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)firstLowerCaseLetterString {
    NSRange flRange = NSMakeRange(0, 1);
    NSString* fl = [self substringWithRange:flRange];
    NSString* fll = [fl lowercaseString];
    NSMutableString *ms = [NSMutableString stringWithString:self];
    [ms replaceCharactersInRange:flRange withString:fll];
    return ms;
}

- (NSString *)stringFromMD5 {
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (BOOL)containsString:(NSString *)subString {
    return [self rangeOfString:subString].location != NSNotFound;
}

- (NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
