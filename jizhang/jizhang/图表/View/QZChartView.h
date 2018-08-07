//
//  QZChartView.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QZChartModel.h"

typedef NS_ENUM(NSInteger, QZChartType) {
    kQZChartTypeExpend = 0,     //支出
    kQZChartTypeInCome,        //收入
};

@interface QZChartView : UIView

@property (nonatomic, assign) QZChartType type;
@property (nonatomic, strong) QZChartModel *model;

@end
