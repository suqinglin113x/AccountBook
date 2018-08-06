//
//  QZJiZhangSettingController.m
//  jizhang
//
//  Created by Adam on 2018/8/2.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZJiZhangSettingController.h"

#import <UserNotifications/UserNotifications.h>
#import "QZJiZhangSettingCell.h"
#import "QZPickView.h"

@interface QZJiZhangSettingController ()
<UITableViewDataSource, UITableViewDelegate, QZPickViewDelegate, UNUserNotificationCenterDelegate>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QZJiZhangSettingController
{
    
    UNMutableNotificationContent *content;
    NSArray *titles;
    NSArray *details;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"记账设置";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    titles = @[@"记账提醒"];
    
    
}
#pragma mark - - UITableViewDataSource - -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QZJiZhangSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[QZJiZhangSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setTitle:titles[indexPath.row] detail:details[indexPath.row] index:indexPath.row];
    [cell.switchB addTarget:self action:@selector(switchAlert:) forControlEvents:UIControlEventValueChanged];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 *kScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 || indexPath.row == 3) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if(indexPath.row == 1) {
        // clockPick
        QZPickView *pick = [[QZPickView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 230 *kScale, kScreenWidth, 230 *kScale)];
        [self.view addSubview:pick];
        pick.p_delegate = self;
        
    } else {
        // weekPick
        
    }
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        
    }
    return _tableView;
}


- (void)switchAlert:(UISwitch *)switchB
{
    if (switchB.isOn) {
        titles = @[@"记账提醒", @"提醒时间", @"提醒周期", @"提醒内容:"];
        details = @[@"", @"23:00", @"周一周二周三周四周五周六", @""];
    } else {
        titles = @[@"记账提醒"];
    }
    [self.tableView reloadData];
}


#pragma mark -- QZPickViewDelegate --
- (void)pickWithHour:(int)hour minute:(int)minute
{
    // 取消之前的通知
    [self cancleNotifi];
    // 添加新的通知
    [self addNotifihour:hour minute:minute];
    
    // 刷新tab
    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d", hour, minute];
    details = @[@"", timeStr, @"周一周二周三周四周五周六", @""];
    [self.tableView reloadData];
}

/** 添加通知*/
- (void)addNotifihour:(int)hour minute:(int)minute
{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                center.delegate = self;
            }
        }];
        
        content = [[UNMutableNotificationContent alloc] init];
        content.title = @"我是标题";
        content.subtitle = @"我是副标题";
        content.body = @"我是内容";
        content.sound = [UNNotificationSound defaultSound];
        content.badge = @1;
        
        NSDateComponents *dateCom = [[NSDateComponents alloc] init];
        
        dateCom.hour = hour;
        dateCom.minute = minute;
        dateCom.second = 0;
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateCom repeats:YES];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"request" content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
        }];
    } else {
        // Fallback on earlier versions
    }
    
    
}

#pragma mark - 通知代理
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
API_AVAILABLE(ios(10.0)){
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
    content.badge = 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
API_AVAILABLE(ios(10.0)){
    completionHandler();
    content.badge = 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}

/** 取消通知*/
- (void)cancleNotifi
{
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"request"]];
    } else {
        // Fallback on earlier versions
    }
}

@end
