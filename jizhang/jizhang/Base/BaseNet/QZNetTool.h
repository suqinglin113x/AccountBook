//
//  QZNetTool.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/7.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QZChartBaseModel.h"
#import "QZAccountBaseModel.h"

@interface QZNetTool : NSObject

//图表
+ (void)getChartDataWithParams:(NSDictionary *)params block:(void(^)(QZChartBaseModel *baseModel, NSError *error))block;

//账单流水
+ (void)getAccountDataWithParams:(NSDictionary *)params block:(void(^)(QZAccountBaseModel *baseModel, NSError *error))block;

//发布
+ (void)postPublishDataWithParams:(NSDictionary *)params block:(void(^)(QZBaseModel *baseModel, NSError *error))block;

@end
