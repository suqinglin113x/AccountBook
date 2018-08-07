//
//  QZNetUrl.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZNetUrl : NSObject

/**
 *  登录
 */
+ (NSString *)QZLoginUrl;

/**
 *  注册
 */
+ (NSString *)QZRegisterUrl;

/**
 *  账单流水
 */
+ (NSString *)QZBillUrl;

/**
 *  图表
 */
+ (NSString *)QZChartUrl;

/**
 *  发布
 */
+ (NSString *)QZPublishUrl;




@end
