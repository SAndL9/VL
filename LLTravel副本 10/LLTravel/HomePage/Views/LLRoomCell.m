//
//  LLRoomCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLRoomCell.h"
#import "UIImageView+WebCache.h"

@interface LLRoomCell ()
@property (weak, nonatomic) IBOutlet UIImageView *roomImageView;
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *roomAreaLab;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLab;
@property (weak, nonatomic) IBOutlet UILabel *floorNumLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

//用于接收临时传递的model
@property(nonatomic,strong)LLRoomDataModel *model;

@end

@implementation LLRoomCell
//给cell 赋值
-(void)setCellDataWith:(LLRoomDataModel*)data{
    //给图片赋值
    //先取出
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",URL_Base,data.cabin_thumb];
    [self.roomImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"默认图2@2x 2"]];
    self.roomTypeLab.text = data.cabin_name;
    self.roomAreaLab.text = data.size;
    self.peopleNumLab.text = data.num;
    self.floorNumLab.text = data.floors;
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",data.second_price_basic];

    _model =data;
    
}
//button的点击事件
- (IBAction)clickTheBookButton:(UIButton *)sender {
    
    self.buttonClicked(_model.type_name);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
