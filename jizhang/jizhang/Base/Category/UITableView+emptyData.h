//
//  UITableView+emptyData.h
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (emptyData)
- (void)noDataViewWitMsg:(NSString *)message forRows:(NSUInteger)rows;

@end
