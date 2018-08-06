//
//  QZFlowViewController.m
//  jizhang
//
//  Created by Adam on 2018/7/31.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZFlowViewController.h"
#import "QZAccountTableView.h"

@interface QZFlowViewController ()

@property (nonatomic, strong) QZAccountTableView *mainView;

@end

@implementation QZFlowViewController

- (QZAccountTableView *)mainView {
    if (_mainView == nil) {
        _mainView = [[QZAccountTableView alloc] initWithFrame:self.view.bounds];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
