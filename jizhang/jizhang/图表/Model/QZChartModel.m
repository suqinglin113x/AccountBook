//
//  QZChartModel.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZChartModel.h"

@implementation QZChartModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : QZChartListModel.class};
}

@end
