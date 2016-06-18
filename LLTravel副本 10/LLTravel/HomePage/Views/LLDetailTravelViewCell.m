//
//  LLDetailTravelViewCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLDetailTravelViewCell.h"
#import "UIImageView+WebCaChe.h"

@implementation LLDetailTravelViewCell

//cell赋值
-(void)setUpCellWithModel:(LLDetailTravelViewModel *)model{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"默认图2@2x 2"]];
    self.nameLab.text = model.product_name;
    self.moneyLab.text = [NSString stringWithFormat:@"￥%@起",model.adult_price];
    
    self.timeLab.text = [NSString stringWithFormat:@"%@出发",model.date_time];
    self.typeLab.text = model.tag_name;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

//设置上面的布局
-(void)setSubViews{
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self addSubview:_iconImageView];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, (size_width - 120), 40)];
    _nameLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nameLab];
    
    
    self.typeLab = [[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(_nameLab.frame)+5, 45, 20)];
    self.typeLab.textColor = [UIColor orangeColor];
    self.typeLab.font = [UIFont systemFontOfSize:10];
    self.typeLab.layer.masksToBounds = YES;
    self.typeLab.layer.borderColor = [UIColor orangeColor].CGColor;
    self.typeLab.layer.borderWidth = 1;
    [self addSubview:_typeLab];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(120, CGRectGetMaxY(_typeLab.frame) + 5, (size_width - 120 - 10 * 2) / 2, 25)];
    self.timeLab.font = [UIFont systemFontOfSize:10];
    [self addSubview:_timeLab];
    
    self.moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(  CGRectGetMaxX(_timeLab.frame) + 65 , CGRectGetMaxY(_typeLab.frame) + 5, (size_width - 120 - 10 * 2) / 2, 25)];
    self.moneyLab.textColor = [UIColor orangeColor];
    self.moneyLab.font = [UIFont systemFontOfSize:10];
    [self addSubview:_moneyLab];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
