//
//  QZNetTool.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZNetTool.h"


@implementation QZNetTool

//图表
+ (void)getChartDataWithParams:(NSDictionary *)params block:(void(^)(QZChartBaseModel *baseModel, NSError *error))block {
    [[BaseNetService sharedManager] POST:[QZNetUrl QZChartUrl] parameters:params success:^(id responseObject) {
        if (block) {
            QZChartBaseModel *chartModel = [QZChartBaseModel yy_modelWithJSON:responseObject];
            block(chartModel,nil);
        }
    } failure:^(NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];
}

@end
