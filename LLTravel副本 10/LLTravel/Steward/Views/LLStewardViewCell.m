//
//  LLStewardViewCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLStewardViewCell.h"

#define kSpacing 10   // 间距
@implementation LLStewardViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置子视图
        [self setLoadSubViews];
    }
    return self;
}

-(void)setLoadSubViews{
    self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(kSpacing, kSpacing, 80, 80)];
    self.iconImage.backgroundColor = [UIColor redColor];
    self.iconImage.layer.cornerRadius = 40;
    self.iconImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImage];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImage.frame) + kSpacing + kSpacing, 5, size_width - CGRectGetMidX(_iconImage.frame) - kSpacing - kSpacing - kSpacing, 40)];
    self.nameLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.nameLabel];
    
    self.casetitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImage.frame) + kSpacing + kSpacing, CGRectGetMaxY(_nameLabel.frame) + 15, 65, 30)];
    self.casetitle.text = @"已提供案例: ";
    self.casetitle.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_casetitle];
    
    
    self.caseLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_casetitle.frame), CGRectGetMaxY(_nameLabel.frame) + 15, 55, 30)];
    self.caseLabel.backgroundColor = [UIColor purpleColor];
    self.caseLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.caseLabel];
    
    self.scoretitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_caseLabel.frame), CGRectGetMaxY(_nameLabel.frame) + 15, 65, 30)];
    self.scoretitle.text = @"综合评分: ";
    self.scoretitle.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.scoretitle];
    
    
    self.scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_scoretitle.frame), CGRectGetMaxY(_nameLabel.frame) + 15, 50, 30)];
    self.scoreLabel.backgroundColor  = [UIColor orangeColor];
    self.scoreLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:self.scoreLabel];
    
    
}
@end
