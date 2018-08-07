//
//  QZMineBottomCell.m
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZMineBottomCell.h"

@interface QZMineBottomCell ()

@property (nonatomic, strong) UIImageView *iconImageV;

@property (nonatomic, strong) UILabel *contentL;
@property (nonatomic, strong) UILabel *detailL;
@property (nonatomic, strong) UIImageView *arrowIv;
@end

@implementation QZMineBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCellInterface];
    }
    
    return self;
}

- (void)setupCellInterface
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageV];
    
    self.contentL = [[UILabel alloc] init];
    self.contentL.textAlignment = 0;
    self.contentL.font = [UIFont systemFontOfSize:14 *kScale];
    [self.contentView addSubview:self.contentL];
    
    self.detailL = [[UILabel alloc] init];
    [self.contentView addSubview:self.detailL];
    self.detailL.textAlignment = 2;
    self.detailL.font = [UIFont systemFontOfSize:12 *kScale];
    self.detailL.textColor = UIColorFromHex(0x666666);
    self.detailL.text = [self getVersion];
    
    self.arrowIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
//    [self.contentView addSubview:self.arrowIv];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageV.frame = CGRectMake(10 *kScale, 0, 25 *kScale, 25 *kScale);
    self.iconImageV.centerY = self.contentView.centerY;
    
    self.contentL.frame = CGRectMake(CGRectGetMaxX(self.iconImageV.frame) + 10 *kScale, 0, 200 *kScale, 30 *kScale);
    self.contentL.centerY = self.contentView.centerY;
    
    self.detailL.frame = CGRectMake(kScreenWidth - 150 *kScale, 0, 130 *kScale, 30 *kScale);
    self.detailL.centerY = self.contentView.centerY;
    
    self.arrowIv.frame = CGRectMake(kScreenWidth - 50*kScale, 0, 25 *kScale, 25 *kScale);
    self.arrowIv.centerY = self.contentView.centerY;
}
- (void)setDic:(NSDictionary *)dic
{
    self.iconImageV.image = [UIImage imageNamed:dic[@"icon"]];
    self.contentL.text = dic[@"title"];
    if ([dic[@"title"] isEqualToString:@"退出登录"]) {
        self.detailL.hidden = YES;
    }
}

- (NSString *)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *version = [NSString stringWithFormat:@"版本号V.%@", appCurVersion];
    return version;
}
@end
