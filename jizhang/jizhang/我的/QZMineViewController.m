//
//  QZMineViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZMineViewController.h"
#import "QZMineTopHead.h"
#import "QZJiZhangSettingController.h"
#import "QZYuSuanSettingController.h"
#import "QZMineBottomCell.h"

@interface QZMineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;
@end

@implementation QZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.tableView];
    
    QZMineTopHead *topHead = [[QZMineTopHead alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300 *kScale)];
    self.tableView.tableHeaderView = topHead;
    
    __weak typeof(self)weakSelf = self;
    topHead.setingBlock = ^(NSInteger k_index) {
        if (k_index == 0) {
            QZJiZhangSettingController *jizhangVC = [QZJiZhangSettingController new];
            
            [weakSelf.navigationController pushViewController:jizhangVC animated:YES];
        } else {
            QZYuSuanSettingController *yusuanVC = [QZYuSuanSettingController new];
            
            [weakSelf.navigationController pushViewController:yusuanVC animated:YES];
        }
    };
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contents.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)self.contents[section]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QZMineBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[QZMineBottomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.dic = self.contents[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50 *kScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 *kScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 0 *kScale;
        _tableView.estimatedSectionHeaderHeight = 10 *kScale;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return _tableView;
}

- (NSArray *)contents
{
    if (_contents == nil) {
        
        _contents = @[@[@{@"icon":@"jizhangshezhi", @"title" : @"关于我们"}], @[@{@"icon":@"jizhangshezhi", @"title" : @"为奇子簿评分"}, @{@"icon":@"jizhangshezhi", @"title" : @"分享APP给基友"}]];
    }
    return _contents;
}
- (void)dealloc
{
    NSLog(@"释放");
}

@end
