//
//  UITableView+emptyData.h
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITableViewNoDataDelegate <NSObject>
- (void)toLogin;
@end

@interface UITableView (emptyData)
/** 展示暂无数据页面*/
- (void)showNoDataViewImg:(NSString *)imageName text:(NSString *)hint btn:(NSString *)btnTitle;

/** 隐藏暂无数据页面*/
- (void)hideNoDataView;

@property (nonatomic, weak) id <UITableViewNoDataDelegate> no_delegate;
@end
