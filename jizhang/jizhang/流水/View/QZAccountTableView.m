//
//  QZAccountTableView.m
//  jizhang
//
//  Created by 邓振娜 on 2018/8/6.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZAccountTableView.h"
#import "QZAccountHeaderView.h"

static NSString *accountTableViewIdentifier = @"accountTableViewIdentifier";

@interface QZAccountTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation QZAccountTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountTableViewIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:accountTableViewIdentifier];
    }
    
    cell.textLabel.text = @"嘿";
    cell.detailTextLabel.text = @"+300.00";
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48 * kScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QZAccountHeaderView *view = [[QZAccountHeaderView alloc] init];
    
    return view;
}


@end
