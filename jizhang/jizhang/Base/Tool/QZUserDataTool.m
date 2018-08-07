//
//  QZUserDataTool.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZUserDataTool.h"

@implementation QZUserDataTool

+ (void)setUserDefaultsValue:(NSString *)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserDefaultsforKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+ (NSString *)getUserId {
    return [self getUserDefaultsforKey:kUserDefaultsId];
}
+ (NSString *)getUserMobile {
    return [self getUserDefaultsforKey:kUserDefaultsMobile];
}

@end
