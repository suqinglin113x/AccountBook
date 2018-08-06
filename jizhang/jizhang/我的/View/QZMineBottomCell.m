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

    self.iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageV];
    
    self.contentL = [[UILabel alloc] init];
    self.contentL.textAlignment = 0;
    self.contentL.font = [UIFont systemFontOfSize:13 *kScale];
    [self.contentView addSubview:self.contentL];
    
    self.arrowIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    [self.contentView addSubview:self.arrowIv];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImageV.frame = CGRectMake(10 *kScale, 0, 25 *kScale, 25 *kScale);
    self.iconImageV.centerY = self.contentView.centerY;
    
    self.contentL.frame = CGRectMake(CGRectGetMaxX(self.iconImageV.frame) + 10 *kScale, 0, 200 *kScale, 30 *kScale);
    self.contentL.centerY = self.contentView.centerY;
    
    self.arrowIv.frame = CGRectMake(kScreenWidth - 50*kScale, 0, 25 *kScale, 25 *kScale);
    self.arrowIv.centerY = self.contentView.centerY;
}
- (void)setDic:(NSDictionary *)dic
{
    self.iconImageV.image = [UIImage imageNamed:dic[@"icon"]];
    self.contentL.text = dic[@"title"];
}
@end
