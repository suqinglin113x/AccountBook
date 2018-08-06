//
//  UITableView+emptyData.m
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "UITableView+emptyData.h"

@implementation UITableView (emptyData)

- (void)noDataViewWitMsg:(NSString *)message forRows:(NSUInteger)rows
{
    if (rows == 0) {
        // 没有数据的时候，UILabel的显示样式
        UIButton *messageBtn = [UIButton new];
        
        [messageBtn setTitle:message forState:UIControlStateNormal];
        messageBtn.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        [messageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        messageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [messageBtn.titleLabel sizeToFit];
        [messageBtn addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundView = messageBtn;
//        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

- (void)refreshData
{
    [self reloadData];
    NSLog(@"重新刷新");
}
@end
