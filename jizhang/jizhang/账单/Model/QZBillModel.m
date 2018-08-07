//
//  QZBillModel.m
//  jizhang
//
//  Created by Adam on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBillModel.h"

@implementation QZBillModel

+ (NSMutableArray *)arrModelWithArr:(NSArray *)arr
{
    NSMutableArray *temArr = [NSMutableArray array];
    for (NSDictionary *dict in arr) {
        
        QZBillModel *billmodel = [[QZBillModel alloc] init];
        [billmodel setValuesForKeysWithDictionary:dict];
        
        [temArr addObject:billmodel];
    }
    
    return temArr;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
