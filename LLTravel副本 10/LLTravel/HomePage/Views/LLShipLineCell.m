//
//  LLShipLineCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLShipLineCell.h"
#import "UIImageView+WebCache.h"
@interface LLShipLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shipImageView; //图片
@property (weak, nonatomic) IBOutlet UILabel *productNameLab;//航线名字
@property (weak, nonatomic) IBOutlet UILabel *priceLab;//价格lab
@property (weak, nonatomic) IBOutlet UILabel *portNameLab; //出发地

@end

@implementation LLShipLineCell

//给cell赋值  model 参数为cell要展示的数据
-(void)setCellDataModel:(LLSelectionTravelDataModel*)model{
    //展示图片
    NSString *imgUrlStr = [NSString stringWithFormat:@"%@%@",URL_Base,model.thumb];
    [self.shipImageView  sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:@"6"]];
    
    //展示产品名称
    self.productNameLab.text = model.product_name;
    //展示价格
    NSString *priceStr = [NSString stringWithFormat:@"￥%@",model.min_price];
    self.priceLab.text = priceStr;
    
    //展示出发地
    NSString *portNameStr = [NSString stringWithFormat:@"%@出发",model.port_name];
    self.portNameLab.text = portNameStr;
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
