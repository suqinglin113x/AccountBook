//
//  QZBillModel.h
//  jizhang
//
//  Created by Adam on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZBillModel : NSObject
@property (nonatomic, copy) NSString *item;
/** 1 收入 2支出*/
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *icon;
+ (NSMutableArray *)arrModelWithArr:(NSArray *)arr;

@end
