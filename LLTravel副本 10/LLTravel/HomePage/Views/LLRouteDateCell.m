//
//  LLRouteDateCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/13.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLRouteDateCell.h"

@interface LLRouteDateCell ()
//日期
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *routeLab;

//三餐
@property (weak, nonatomic) IBOutlet UILabel *breakfastLab;
@property (weak, nonatomic) IBOutlet UILabel *lauchLab;
@property (weak, nonatomic) IBOutlet UILabel *dinnerLab;



@end


@implementation LLRouteDateCell


//给cell赋值
-(void)setCellDataWith:(LLDaysModel*)model{
    self.dayLab.text = [NSString stringWithFormat:@"第%@天",model.day];
    self.routeLab.text = model.title;
    //0表示自理 1 表示邮轮提供
    NSInteger breakfast = [model.breakfast integerValue];
    NSInteger lanuch =[model.lunch integerValue];
    NSInteger dinner = [model.dinner integerValue];
    
    self.breakfastLab.text = breakfast == 0 ?@"敬请自理":@"含邮轮餐";
    self.lauchLab.text = lanuch == 0 ?@"敬请自理":@"含邮轮餐";
    self.dinnerLab.text = dinner == 0 ?@"敬请自理":@"含邮轮餐";
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
