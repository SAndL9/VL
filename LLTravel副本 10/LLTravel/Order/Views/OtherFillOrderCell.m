//
//  FillOrderCell.m
//  VTravel
//
//  Created by zhangmeng on 16/6/16.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#import "OtherFillOrderCell.h"

@interface OtherFillOrderCell ()

@property (nonatomic, strong) LLRoomDataModel *model;
@property (nonatomic, strong) NSString *stock; //存放最初未改变的剩余数
@end

@implementation OtherFillOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//儿童加号事件
- (IBAction)childAddBtnClick:(id)sender {
    //    self.childAdd();
    NSInteger totalNum =  [self.model.childNumStr integerValue];
    NSInteger canSelectNum = [self.model.num integerValue] * [self.stock integerValue];
  
    //计算总人数占用的房间
    NSInteger usedRoomNum = totalNum/[self.model.num integerValue] + (totalNum%[self.model.num integerValue] >0 ? 1:0);
    if (self.stock.integerValue != usedRoomNum + self.model.stock.integerValue ) {
        //
        self.stock = [NSString stringWithFormat:@"%ld",usedRoomNum + self.model.stock.integerValue];
    }
    if (canSelectNum - totalNum > 0 || totalNum%self.model.num.integerValue >0) {
        //设置减少可用
        [self.child_Reduce_Btn setImage:[UIImage imageNamed:@"减少可用"] forState:(UIControlStateNormal)];
        totalNum ++;
        self.model.childNumStr = [NSString stringWithFormat:@"%ld",totalNum];
        self.childNumLab.text = self.model.childNumStr;
        //修改当前房间剩余数
        self.stockLab.text = [NSString stringWithFormat:@"%@间",[self judgeTheStockRoomNumWith:self.model]];
        
        if (totalNum == self.stock.integerValue * self.model.num.integerValue) {
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
        }
    }else if(totalNum == self.stock.integerValue * self.model.num.integerValue){
        [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
    }
}

//儿童减号事件
- (IBAction)childReduceBtnClick:(id)sender {
    //    self.childReduce();
    if (self.model.childNumStr.integerValue >0) {
        NSInteger childNum = [self.model.childNumStr integerValue];
        childNum --;
        self.model.childNumStr = [NSString stringWithFormat:@"%ld",childNum];
        self.childNumLab.text = self.model.childNumStr;
        //修改当前房间剩余数
        self.stockLab.text = [NSString stringWithFormat:@"%@间",[self judgeTheStockRoomNumWith:self.model]];
        if (childNum == 0) {
            [self.child_Reduce_Btn setImage:[UIImage imageNamed:@"减少不可用"] forState:(UIControlStateNormal)];
        }
        if (childNum < self.stock.integerValue*self.model.num.integerValue){
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }
    }
}

- (void)setCellDataWith:(LLRoomDataModel *)model {
    //保存model
    self.model = model;
    //设置房间类型
    self.roomTypeLab.text = model.cabin_name;
    //设置房间信息
    self.roomInfoLab.text = [NSString stringWithFormat:@"%@㎡，%@层，入住%@人",model.size,model.floors,model.num];
    //设置剩余舱房
    self.stockLab.text = [NSString stringWithFormat:@"%@间",model.stock];
    self.stock = model.stock;
    //设置价格
    self.priceLab.text = [NSString stringWithFormat:@"￥%@/人",[self judgeThePriceOfRoomWith:model]];

    //设置儿童人数
    self.childNumLab.text = model.childNumStr;
    

    //入住的总数
    NSInteger totalNum =  [model.childNumStr integerValue];
    //当前剩余房间数可入住的总人数
    NSInteger canSelectNum = [model.num integerValue] * [model.stock integerValue];
    
    
    if (canSelectNum>0 || (totalNum%model.num.integerValue >0)) {
        [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
    }else {
        [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
    }
    //儿童减少button
    if ([model.childNumStr integerValue] > 0) {
        [self.child_Reduce_Btn setImage:[UIImage imageNamed:@"减少可用"] forState:(UIControlStateNormal)];
    }else{
        [self.child_Reduce_Btn setImage:[UIImage imageNamed:@"减少不可用"] forState:(UIControlStateNormal)];
    }
}
#pragma mark - 显示房间价格
- (NSString *)judgeThePriceOfRoomWith:(LLRoomDataModel *)model {
    //判断如果second_price为0，取出显示的价格为second_price_basic,如果两个都为0，取出显示价格为first_price
    NSString * price = model.second_price;
    if ([price integerValue] == 0) {
        price = model.second_price_basic ;
    }
    if ([price integerValue] == 0) {
        price = model.first_price_basic ;
    }
    return price;
}

#pragma mark - 计算当前剩余房间数
- (NSString *)judgeTheStockRoomNumWith:(LLRoomDataModel *)model {
    //计算当前一共多少人
    NSInteger total =  [model.childNumStr integerValue];
    //计算总人数占用的房间
    NSInteger usedRoomNum = total/[model.num integerValue] + (total%[model.num integerValue] >0 ? 1:0);
    //剩余房间数
    NSInteger newStock = [self.stock integerValue] - usedRoomNum;
    
    if (newStock < 0) {
        newStock = self.stock.integerValue;
        self.stock = [NSString stringWithFormat:@"%ld",self.stock.integerValue+usedRoomNum];
    }
    self.model.stock = [NSString stringWithFormat:@"%ld",newStock];
    
    
    
    return [NSString stringWithFormat:@"%ld",newStock];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
