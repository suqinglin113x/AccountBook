//
//  NSString+RegexCategory.m
//  jizhang
//
//  Created by Adam on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "NSString+RegexCategory.h"

@implementation NSString (RegexCategory)

- (BOOL)isMobilePhone
{
    NSString * MOBIL = @"^1(3[0-9]|4[579]|5[0-35-9]|7[01356]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    if ([regextestmobile evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}

@end
