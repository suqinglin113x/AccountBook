//
//  QZChartViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZChartViewController.h"
#import "QZChartView.h"
#import "QZNaviTopView.h"

@interface QZChartViewController ()<QZChartTopViewDelegate>

@property (nonatomic, strong) QZChartView *expendChartView;
@property (nonatomic, strong) QZChartView *incomeChartView;
@property (nonatomic, strong) QZNaviTopView *topView;

@end

@implementation QZChartViewController

- (QZNaviTopView *)topView {
    if (_topView == nil) {
        _topView = [[QZNaviTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarAndStatusBarHeight)];
        _topView.delegate = self;
    }
    return _topView;
}

- (QZChartView *)incomeChartView {
    if (_incomeChartView == nil) {
        _incomeChartView = [[QZChartView alloc] initWithFrame:self.view.bounds];
        _incomeChartView.type = kQZChartTypeInCome;
    }
    return _incomeChartView;
}

- (QZChartView *)expendChartView {
    if (_expendChartView == nil) {
        _expendChartView = [[QZChartView alloc] initWithFrame:self.view.bounds];
        _expendChartView.type = kQZChartTypeExpend;
    }
    return _expendChartView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showExpendChart];
    [self selectExpend];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)setUI {
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(kNavBarAndStatusBarHeight);
    }];
    
    [self.view addSubview:self.incomeChartView];
    [self.incomeChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavBarAndStatusBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.view addSubview:self.expendChartView];
    [self.expendChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavBarAndStatusBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
//    [self showExpendChart];
}

#pragma mark - network
- (void)loadDataWithType:(NSString *)type {
    
    if (![QZUserDataTool getUserId]) {
        return;
    }
    
//    NSDictionary *dict = @{@"userId":@"1",@"type":type};
    NSDictionary *dict = @{@"userId":[QZUserDataTool getUserId],@"type":type};
    [QZNetTool getChartDataWithParams:dict block:^(QZChartBaseModel *baseModel, NSError *error) {
        if (error) {
            [self showHint:kNetError];
            return ;
        }
        if (baseModel.code.integerValue == 200) {
            QZChartModel *model = baseModel.data;
            if (type.integerValue == 1) {
                self.incomeChartView.model = model;
            }else {
                self.expendChartView.model = model;
            }
        }else {
            [self showHint:baseModel.msg];
        }
    }];
    
    
}



#pragma mark - QZChartTopViewDelegate
- (void)showExpendChart {
    NSLog(@"支出");
    
    self.expendChartView.hidden = NO;
    self.incomeChartView.hidden = YES;
    [self loadDataWithType:@"2"];
}

- (void)showIncomeChart {
    NSLog(@"收入");
    
    self.expendChartView.hidden = YES;
    self.incomeChartView.hidden = NO;
    [self loadDataWithType:@"1"];
}

- (void)selectExpend {
    __weak typeof(self) weakSelf = self;
    [weakSelf.topView selcetExpend];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
