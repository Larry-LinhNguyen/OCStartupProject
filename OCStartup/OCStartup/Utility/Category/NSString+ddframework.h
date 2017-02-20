//
//  NSString+ddframework.h
//  OCStartup
//
//  Created by Yanchen Wang on 20/02/2017.
//  Copyright © 2017 Yanchen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ddframework)

- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;

- (NSString *)trim;
- (NSString *)firstLowerCaseLetterString;

- (NSString *)stringFromMD5;
- (BOOL)containsString:(NSString *)subString;

// remove html tag
- (NSString *)stringByStrippingHTML;

@end
