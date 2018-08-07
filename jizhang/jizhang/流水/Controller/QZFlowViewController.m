//
//  QZFlowViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZFlowViewController.h"
#import "QZAccountTableView.h"
#import "UITableView+emptyData.h"

@interface QZFlowViewController ()

@property (nonatomic, strong) QZAccountTableView *mainView;

@end

@implementation QZFlowViewController

- (QZAccountTableView *)mainView {
    if (_mainView == nil) {
        _mainView = [[QZAccountTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
    }
    return _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账单流水";
    
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
    [self loadData];
}


#pragma mark - network
- (void)loadData {
    
    if (![QZUserDataTool getUserId]) {
        self.mainView.model = nil;
        [self noDataOrError];
        return;
    }
    
    NSDictionary *dict = @{@"userId" : [QZUserDataTool getUserId]};
    [QZNetTool getAccountDataWithParams:dict block:^(QZAccountBaseModel *baseModel, NSError *error) {
        [self.mainView.mj_header endRefreshing];
        if (error) {
            self.mainView.model = nil;
            [self showHint:kNetError];
            [self noDataOrError];
            return ;
        }
        
        if (baseModel.code.integerValue == 200) {
            [self.mainView removeNoDataView];
            QZAccountModel *model = baseModel.data;
            self.mainView.model = model;
        }else {
            self.mainView.model = nil;
            [self showHint:baseModel.msg];
            [self noDataOrError];
        }
        
    }];
    
    
}


- (void)noDataOrError {
    if (!self.mainView.model) {
        [self.mainView showNoDataViewImg:@"nodata" text:kNoData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
