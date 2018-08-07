//
//  QZNetUrl.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZNetUrl.h"


//测试服
#define QZServer @"http://192.168.1.185/zhangben/public/"

//正式
//#define QZServer @"http://qzqsd.com/"

@implementation QZNetUrl

/**
 *  登录
 */
+ (NSString *)QZLoginUrl {
    return [NSString stringWithFormat:@"%@%@",QZServer,@"api/account/login"];
}

/**
 *  注册
 */
+ (NSString *)QZRegisterUrl {
    return [NSString stringWithFormat:@"%@%@",QZServer,@"api/account/register"];
}

/**
 *  账单流水
 */
+ (NSString *)QZBillUrl {
    return [NSString stringWithFormat:@"%@%@",QZServer,@"api/account/billwater"];
}

/**
 *  图表
 */
+ (NSString *)QZChartUrl {
    return [NSString stringWithFormat:@"%@%@",QZServer,@"api/account/moneytype"];
}

/**
 *  发布
 */
+ (NSString *)QZPublishUrl {
    return [NSString stringWithFormat:@"%@%@",QZServer,@"api/account/addbill"];
}

@end
