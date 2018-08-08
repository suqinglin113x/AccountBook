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
#import "QZBillPickView.h"


@interface QZBillViewController ()
<UITableViewDataSource, UITableViewDelegate, UITableViewNoDataDelegate, QZBillTopHeadDelegate, QZBillPickViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) QZBillTopHead *topHead;
@end

@implementation QZBillViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    QZBillTopHead *topHead = [[QZBillTopHead alloc] init];
    self.topHead = topHead;
    topHead.frame = CGRectMake(0, 0, kScreenWidth, 200 *kScale);
    topHead.backgroundColor = UIColorFromHex(0xffde01);
    
    topHead.top_delegate = self;
    [self.view addSubview:topHead];
    
    [self addPullRefresh];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark - action
- (void)loadData
{
    NSDictionary *dict = @{@"userId" : [QZUserDataTool getUserId]};
    [[BaseNetService sharedManager] POST:[QZNetUrl QZBillUrl] parameters:dict success:^(id responseObject) {
        [self.dataArr removeAllObjects];
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            
            NSArray *dicArr = responseObject[@"data"][@"list"];
            NSArray *temArr = [QZBillModel arrModelWithArr:dicArr];
            [self.dataArr addObjectsFromArray:temArr];
            self.datasource = self.dataArr;
            //
            self.topHead.dict = responseObject[@"data"];
        } else {
            [self showHint:responseObject[@"msg"]];
            self.topHead.dict = nil;
        }
        [self showNODataView:responseObject[@"msg"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self showHint:kNetError];
        [self.tableView.mj_header endRefreshing];
        [self showHint:kNetError];
        [self showNODataView:kNetError];
    }];
}

- (void)addPullRefresh
{
   
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView hideNoDataView];
        if (![[NSUserDefaults standardUserDefaults] valueForKey:USERID_KEY]) {
            [self.tableView showNoDataViewImg:@"记账2" text:@"每一笔账，都是生活的点滴" btn:@"登录"];
            self.topHead.dict = nil;
            self.topHead.itemTitle = nil;
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.topHead.itemTitle = @"日常";
        [self loadData];
    }];
}

- (void)showNODataView:(NSString *)hint
{
    
    [self.tableView hideNoDataView];
    if (self.dataArr.count == 0) {
        [self.tableView showNoDataViewImg:@"记账1" text:hint btn:@"同步数据"];
    } else {
    }
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
    return 0 *kScale;
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
    
    return nil;
}
#pragma mark -- UITableViewNoDataDelegate --
- (void)toLogin
{
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USERID_KEY]) {
        // 同步数据
        [self.tableView.mj_header beginRefreshing];
        return;
    }
    QZLoginViewController *login = [QZLoginViewController new];
    [self.navigationController pushViewController:login animated:YES];
}

#pragma mark -- QZBillTopHeadDelegate ---
- (void)choiceItem
{
    // 添加pick
    QZBillPickView *pick = [[QZBillPickView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:pick];
    pick.b_delegate = self;
}
#pragma mark -- QZBillPickViewDelegate ---
- (void)pickWithItem:(NSString *)item
{
    // 筛选数组
    self.dataArr = [self.datasource mutableCopy];
    [self.datasource enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QZBillModel *model = (QZBillModel *)obj;
        if (![model.item isEqualToString:item]) {
            [self.dataArr removeObject:model];
            [self showNODataView:@"暂无数据"];
        }
    }];
    
    [self.tableView reloadData];
    // 记录item
    self.topHead.itemTitle = item;
}
#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)datasource
{
    if (_datasource == nil) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
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
