//
//  QZChartModel.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBaseModel.h"
#import "QZChartListModel.h"

@interface QZChartModel : QZBaseModel

@property (nonatomic, copy) NSString *maxMoney;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *moneyToal;
@property (nonatomic, strong) NSArray *list;

@end
