//
//  QZJiZhangSettingCell.m
//  jizhang
//
//  Created by Adam on 2018/8/3.
//  Copyright © 2018年 qzxq. All rights reserved.
//

#import "QZJiZhangSettingCell.h"

@interface QZJiZhangSettingCell ()
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UILabel *detailL;
@property (nonatomic, weak) UIImageView *arrowIv;
@end

@implementation QZJiZhangSettingCell

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
    UILabel *titleL = [[UILabel alloc] init];
    [self.contentView addSubview:titleL];
    titleL.textAlignment = 1;
    titleL.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15 *kScale];
    titleL.textColor = [UIColor blackColor];
    self.titleL = titleL;
    
    UISwitch *switchB = [[UISwitch alloc] init];
    [self.contentView addSubview:switchB];
    switchB.on = NO;
    
    switchB.onTintColor = UIColorFromHex(0xffde01);
    self.switchB = switchB;
    
    UILabel *detailL = [[UILabel  alloc] init];
    [self.contentView addSubview:detailL];
    detailL.textColor = [UIColor redColor];
    detailL.text = @"08:00";
    detailL.font = [UIFont systemFontOfSize:14 *kScale];
    detailL.textAlignment = 2;
    self.detailL = detailL;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.contentView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"arrow_right"];
    self.arrowIv = imageV;
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleL.frame = CGRectMake(10, 0, 80*kScale, 30);
    self.titleL.centerY = self.contentView.centerY;
    
    self.switchB.frame = CGRectMake(kScreenWidth - 60 *kScale, 0, 50, 30);
    self.switchB.centerY = self.contentView.centerY;
    
    self.arrowIv.frame = CGRectMake(kScreenWidth - 40, 0, 25, 25);
    self.arrowIv.centerY = self.contentView.centerY;
    
    self.detailL.frame = CGRectMake(CGRectGetMinX(self.arrowIv.frame) - 200*kScale, 0, 200 *kScale, 30);
    self.detailL.centerY = self.contentView.centerY;
    
}

- (void)setTitle:(NSString *)title detail:(NSString *)detail index:(NSUInteger)index
{
    self.titleL.text = title;
    self.detailL.text = detail;
    if (index == 0) {
        self.switchB.hidden = NO;
        self.detailL.hidden = YES;
        self.arrowIv.hidden = YES;
    } else if (index == 3) {
        self.switchB.hidden = YES;
        self.detailL.hidden = YES;
        self.arrowIv.hidden = YES;
    } else {
        self.switchB.hidden = YES;
        self.detailL.hidden = NO;
        self.arrowIv.hidden = NO;
    }
}

//- (void)switchAlert:(UISwitch *)switchB
//{
//    if (switchB.isOn) {
//        
//    }
//}
@end
