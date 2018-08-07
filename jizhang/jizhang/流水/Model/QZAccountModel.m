//
//  QZAccountModel.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZAccountModel.h"

@implementation QZAccountModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : QZChartListModel.class};
}

@end
