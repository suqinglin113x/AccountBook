//
//  QZAccountModel.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBaseModel.h"
#import "QZChartListModel.h"

@interface QZAccountModel : QZBaseModel

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy) NSString *expenditure;
@property (nonatomic, copy) NSString *income;
@property (nonatomic, copy) NSString *surplus;


@end
