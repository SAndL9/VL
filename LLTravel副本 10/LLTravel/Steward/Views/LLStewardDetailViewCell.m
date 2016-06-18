//
//  LLStewardDetailViewCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/7.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLStewardDetailViewCell.h"

@implementation LLStewardDetailViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews{
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30 , 30)];
    
    [self addSubview:_iconImageView];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 85, 44)];
    [self addSubview:_nameLab];
    
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(40 + 85 + 10, 0, size_width - 40 - 85 - 10, 44)];
    [self addSubview:_detailLab];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
