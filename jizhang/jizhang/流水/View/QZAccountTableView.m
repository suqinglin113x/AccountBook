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

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
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
    return self.model.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountTableViewIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:accountTableViewIdentifier];
    }
    
    QZChartListModel *listModel = self.model.list[indexPath.row];
    cell.textLabel.text = listModel.item;
    NSString *flag = @"+";
    if (listModel.type.integerValue == 2) {
        flag = @"-";
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",flag,listModel.money];
    
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
    view.model = self.model;
    return view;
}


- (void)setModel:(QZAccountModel *)model {
    _model = model;
    
    [self reloadData];
}

@end
