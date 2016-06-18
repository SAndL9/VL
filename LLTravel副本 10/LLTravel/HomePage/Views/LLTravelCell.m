//
//  LLTravelCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/9.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLTravelCell.h"
#import "UIImageView+WebCache.h"
@implementation LLTravelCell

-(void)setUpCellWithModel:(LLTravelModel*)model{
    if ([model.picture hasPrefix:@"http://"]) {
         [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"6"]];
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",URL_Base,model.picture];
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"6"]];
    }
    
   
    self.nameLab.text = [NSString stringWithFormat:@"<%@>",model.product_name];
    self.priceLab.text = [NSString stringWithFormat:@"微旅价:￥%@起",model.adult_price];
    self.tag_nameLab.text = model.travel_tag;
    
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubVies];
    }
    return  self;
}

-(void)setSubVies{
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size_width, 200)];
    [self.contentView addSubview:self.backImageView];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10,  CGRectGetMaxY(_backImageView.frame), size_width - 10,35)];
    _nameLab.font = [UIFont systemFontOfSize:15];
//    _nameLab.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_nameLab];
    
    //--------------通过传入的请求的数据  也就是 标签的个数的时候 来进行创建----------------
    
    self.tag_nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLab.frame), 100, 35)];
//    _tag_nameLab.backgroundColor = [UIColor orangeColor];
    _tag_nameLab.font = [UIFont systemFontOfSize:12];
    _tag_nameLab.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_tag_nameLab];
    
    //设置边框是否可以切割
    _tag_nameLab.layer.masksToBounds = YES;
    //设置边框颜色
    _tag_nameLab.layer.borderColor = [UIColor orangeColor].CGColor;
    //设置边框的宽度
    _tag_nameLab.layer.borderWidth = 1;
    
    
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_tag_nameLab.frame), 200 , 35)];
    _priceLab.font = [UIFont systemFontOfSize:14];
    _priceLab.textColor = [UIColor orangeColor];
//    _priceLab.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:_priceLab];
    
    
    
    
    self.buyLab = [[UILabel alloc]initWithFrame:CGRectMake(size_width - 20 - 90, CGRectGetMaxY(_tag_nameLab.frame) , 86, 35)];
    _buyLab.backgroundColor = [UIColor orangeColor];
    _buyLab.text = @"立即抢购";
    _buyLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_buyLab];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
