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
#import "QZLoginViewController.h"

@interface QZMineViewController ()
<UITableViewDataSource, UITableViewDelegate, QZMineTopHeadDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) QZMineTopHead *topHead;
@end

@implementation QZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    self.topHead = [[QZMineTopHead alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200 *kScale)];
    self.topHead.m_delegate = self;
    self.tableView.tableHeaderView = self.topHead;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark -- table --
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
    if (indexPath.section == 1 && [[NSUserDefaults standardUserDefaults] valueForKey:USERID_KEY]) {
        [self logout];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51 *kScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10 *kScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

#pragma mark - -QZMineTopHeadDelegate
- (void)toLogin
{
    
    QZLoginViewController *loginV = [QZLoginViewController new];
    [self.navigationController pushViewController:loginV animated:YES];
}

#pragma mark -- method --
/** 退出登录*/
- (void)logout
{
    // 退出登录
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showHint:@"已退出"];
        // 清除userId
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:USERID_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self viewWillAppear:YES];
    }];
    [alertVC addAction:cancle]; [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -- lazy --
- (UITableView *)tableView
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = UIColorFromHex(0xf8f8f8);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 0 *kScale;
        _tableView.estimatedSectionHeaderHeight = 10 *kScale;
        _tableView.scrollEnabled = NO;
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
        
        _contents = @[@[@{@"icon":@"关于我们", @"title" : @"关于我们"}], @[@{@"icon":@"退出登录", @"title" : @"退出登录"}]];
    }
    return _contents;
}
- (void)dealloc
{
    NSLog(@"释放");
}

@end
