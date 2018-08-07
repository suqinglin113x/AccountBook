//
//  QZBillViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZBillViewController.h"
#import "QZLoginViewController.h"
#import "QZBillTopHead.h"
#import "UITableView+emptyData.h"
#import "QZBillBottomCell.h"
#import "QZBillModel.h"


@interface QZBillViewController ()
<UITableViewDataSource, UITableViewDelegate, UITableViewNoDataDelegate, QZBillTopHeadDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation QZBillViewController
{
    int a;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    a = 0;
    
    
    QZBillTopHead *topHead = [[QZBillTopHead alloc] init];
    topHead.frame = CGRectMake(0, 0, kScreenWidth, 200 *kScale);
    topHead.backgroundColor = UIColorFromHex(0xffde01);
    topHead.top_delegate = self;
    [self.view addSubview:topHead];
    
    
    [self.view addSubview:self.tableView];
    [self loadData];
    [self addPullRefresh];
}

#pragma mark - action
- (void)loadData
{
    
    //
    NSString *urlStr = @"http://192.168.1.185/zhangben/public/api/account/billwater";
    NSDictionary *dict = @{@"userId" : @"1"};
    [[BaseNetService sharedManager] POST:urlStr parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [self.dataArr removeAllObjects];
            NSArray *dicArr = responseObject[@"data"][@"list"];
            NSArray *temArr = [QZBillModel arrModelWithArr:dicArr];
            [self.dataArr addObjectsFromArray:temArr];
            
        } else {
            NSLog(@"请求错误%@", responseObject);
        }
        if (self.dataArr.count == 0) {
            [self.tableView showNoDataViewImg:@"记账2" text:@"每一笔账，都是生活的点滴" btn:@"同步数据"];
        } else {
            [self.tableView hideNoDataView];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)addPullRefresh
{
   
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
    }];
}

#pragma mark -- UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QZBillBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[QZBillBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.billModel = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*kScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30 *kScale;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *bg = [UIView new];
    bg.backgroundColor = UIColorFromHex(0xf8f8f8);
    UILabel *timeL = [UILabel new];
    timeL.frame = CGRectMake(15 *kScale, 0, 80 *kScale, 30 *kScale);
    timeL.centerY = 15 *kScale;
    
    timeL.text = @"08月02日 周四";
    timeL.font = [UIFont systemFontOfSize:10 *kScale];
    [bg addSubview:timeL];
    
    return bg;
}
#pragma mark -- UITableViewNoDataDelegate --
- (void)loginOfNoDataView
{
    QZLoginViewController *login = [QZLoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark -- QZBillTopHeadDelegate ---
- (void)choiceItem:(NSString *)item
{
    NSLog(@"替换掉日常:%@", item);
}


#pragma mark -- lazy
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        
    }
    return _dataArr;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200 *kScale, kScreenWidth, kScreenHeight - 200 *kScale - self.tabBarController.tabBar.height) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.no_delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
    
}



@end
