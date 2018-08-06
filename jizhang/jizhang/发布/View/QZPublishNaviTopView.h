//
//  QZPublishNaviTopView.h
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZPublishNaviTopViewDelegate <NSObject>
@optional
- (void)cancelTopClick;
- (void)saveTopClick;
- (void)showPublishTopExpend;
- (void)showPublishTopIncome;
@end

@interface QZPublishNaviTopView : UIView

@property (nonatomic, weak) id<QZPublishNaviTopViewDelegate> delegate;

@end
