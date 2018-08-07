//
//  QZUserDataTool.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserDefaultsId      @"userId"
#define kUserDefaultsMobile      @"userMobile"

@interface QZUserDataTool : NSObject

+ (void)setUserDefaultsValue:(NSString *)value forKey:(NSString *)key;
+ (NSString *)getUserDefaultsforKey:(NSString *)key;

+ (NSString *)getUserId;
+ (NSString *)getUserMobile;

@end
