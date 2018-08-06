//
//  QZNaviTopView.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZChartTopViewDelegate <NSObject>
@optional
- (void)showExpendChart;
- (void)showIncomeChart;
@end

@interface QZNaviTopView : UIView

@property (nonatomic, weak) id<QZChartTopViewDelegate> delegate;

@end
