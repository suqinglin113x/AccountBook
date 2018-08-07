//
//  QZBillTopHead.h
//  jizhang
//
//  Created by Adam on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QZBillTopHeadDelegate <NSObject>
- (void)choiceItem;
@end

@interface QZBillTopHead : UIView
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, copy) NSString *itemTitle;
@property (nonatomic, weak) id <QZBillTopHeadDelegate>top_delegate;

@end
