//
//  LLShipCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLShipCell.h"
#import "UIImageView+WebCache.h"
@implementation LLShipCell

//展示cell
-(void)setUpDataModel:(LLShipModel*)model{
    //配置头文件
    NSString *imagUrl = [NSString stringWithFormat:@"%@%@",URL_Base,model.thumb];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"默认图2@2x 2"]]];
    //名字
    self.nameLab.text = model.product_name;
    //出发
    self.bottomLab.text = [NSString stringWithFormat:@"%@出发",model.port_name];
    //钱
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@",model.min_price];
    
}
//展示门票cell
-(void)setUpDataTicketModel:(LLTicketModel*)model{
    
    [self.iconImageView  sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"默认图2@2x 2"]]];
    //名字
    self.nameLab.text = model.scenic_name;
    //景区
    self.bottomLab.text = model.place_level;
    //钱
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@",model.start_price];
    
    
}
//展示游学
-(void)setUpDataStudyModel:(LLStudyModel *)model{
    NSString *imagUrl = [NSString stringWithFormat:@"%@/upload/thumb/%@",URL_Base,model.thumb];
    
    [self.iconImageView  sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"默认图2@2x 2"]]];
    
    //名字
    self.nameLab.text = model.name;
    //日期
    self.bottomLab.text = model.setoff_date;
    //钱
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@",model.camper_price];

}
- (void)awakeFromNib {
    // Initialization code
    self.nameLab.text = @"11111";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAddSubViews];
        
    }
    return self;
}

-(void)setAddSubViews{
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 90, 90)];
//    self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"默认图2@2x 2"]];
    [self addSubview:_iconImageView];
    
    CGFloat S_width = size_width - CGRectGetMaxX(_iconImageView.frame) - 10 ;
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, 5, S_width - 10, 35)];
    _nameLab.numberOfLines = 0;
    [self addSubview:_nameLab];
    
    self.bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, CGRectGetMaxY(_nameLab.frame) + 15, (S_width - 15) / 2, 35)];
    _bottomLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_bottomLab];
    
    self.moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(size_width - 10 - (S_width - 15) / 2 , CGRectGetMaxY(_nameLab.frame) + 15, (S_width - 15) / 2, 35)];
    _moneyLab.textAlignment = NSTextAlignmentRight;
    _moneyLab.textColor = [UIColor orangeColor];
    [self addSubview:_moneyLab];
    
    
    
}
@end
