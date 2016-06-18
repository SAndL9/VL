//
//  LLFillOrderCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/16.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLFillOrderCell.h"

@interface LLFillOrderCell ()

@property(nonatomic,strong)LLRoomDataModel *model;

@property(nonatomic,strong)NSString *stock;//存放最初未改变的剩余量

@end

@implementation LLFillOrderCell


#pragma mark----Button 点击事件
//成人加号
- (IBAction)adultAddBtnClick:(UIButton *)sender {
//        //减号点击.... ---------可以在外面设置一个变量 然后默认 设置一个值 然后 每次点击的时候 进行设置状态
//    [self.adult_Reduct_Btn setImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
//
//    
//    //如果满足当前成人数和小孩数之后 小于小于当前房间剩余舱房所容乃的总人数  回调block
//    if ([self.model.adultNumStr integerValue] + [self.model.childNumStr integerValue] < [self.model.num integerValue] * [self.stock integerValue]) {
//       
//        self.adultAdd();
//
//    }else{
//        [self.adult_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
//    }
    
    //设置减少可用
    [self.adult_Reduct_Btn setImage:[UIImage imageNamed:@"减少可用"] forState:(UIControlStateNormal)];
    //如果满足当前成人数和儿童数总和小于当前剩余房间数可容纳的总数，回调block
    if ([self.model.adultNumStr integerValue] + [self.model.childNumStr integerValue] < [self.model.num integerValue] * [self.stock integerValue]) {
        //设置儿童增加可用
        [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        //成人数+1
        NSInteger adultNum = [self.model.adultNumStr integerValue];
        adultNum ++;
        self.model.adultNumStr = [NSString stringWithFormat:@"%ld",adultNum];
        self.adultNumLab.text = self.model.adultNumStr;
        //修改当前房间剩余数
        self.stockLab.text = [NSString stringWithFormat:@"%@间",[self judgeTheStockRoomNumWith:self.model]];
        //如果人数到达上限成人添加按钮和儿童添加按钮不可用
        if (adultNum + [self.model.childNumStr integerValue]  == [self.model.num integerValue] * [self.stock integerValue]) {
            [self.adult_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
        }
        //回调回去当前的价格
        self.adultAdd([self judgeThePriceOfUsedRoom:self.model]);
    }

   

}
//儿童加号
- (IBAction)childAddBtnClick:(UIButton *)sender {

    NSInteger totalNum = [self.model.adultNumStr integerValue] + [self.model.childNumStr integerValue];
    NSInteger canSelectNum = [self.model.num integerValue] * [self.stock integerValue];
    NSInteger childNum = [self.model.childNumStr integerValue];
    NSInteger childCanSelect = [self.model.adultNumStr integerValue]*([self.model.num integerValue] - 1);
    
    if (((totalNum < canSelectNum) && childNum < childCanSelect) || totalNum%self.model.num.integerValue >0) {
        //设置减少可用
        [self.child_Reduct_Btn setImage:[UIImage imageNamed:@"减少可用"] forState:(UIControlStateNormal)];
        childNum ++;
        self.model.childNumStr = [NSString stringWithFormat:@"%ld",childNum];
        self.childNumLab.text = self.model.childNumStr;
        //修改当前房间剩余数
        self.stockLab.text = [NSString stringWithFormat:@"%@间",[self judgeTheStockRoomNumWith:self.model]];
        //如果
        if (childNum == childCanSelect) {
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
        }else if(([self.model.adultNumStr integerValue] + [self.model.childNumStr integerValue]) == canSelectNum){
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
            [self.adult_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
        }
        //回调回去当前的价格
        self.childAdd([self judgeThePriceOfUsedRoom:self.model]);
    }

}
//成人减号
- (IBAction)adultReduceBtnClick:(UIButton *)sender {
  
    if (self.model.adultNumStr.integerValue>0) {
        [self.adult_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        NSInteger adultNum = [self.model.adultNumStr integerValue];
        adultNum --;
        self.model.adultNumStr = [NSString stringWithFormat:@"%ld",adultNum];
        self.adultNumLab.text = self.model.adultNumStr;
        
        //判断当前可添加儿童数
        NSInteger childNum = self.model.adultNumStr.integerValue * (self.model.num.integerValue-1);
        if (self.model.childNumStr.integerValue >= childNum) {
            //更新儿童数据
            self.model.childNumStr = [NSString stringWithFormat:@"%ld",childNum];
            self.childNumLab.text = self.model.childNumStr;
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
        }
        //修改当前房间剩余数
        self.stockLab.text = [NSString stringWithFormat:@"%@间",[self judgeTheStockRoomNumWith:self.model]];
        
        if (adultNum == 0) {
            [self.adult_Reduct_Btn setImage:[UIImage imageNamed:@"减少不可用"] forState:(UIControlStateNormal)];
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:(UIControlStateNormal)];
            [self.child_Reduct_Btn setImage:[UIImage imageNamed:@"减少不可用"] forState:(UIControlStateNormal)];
        }else if((adultNum*(self.model.num.integerValue-1)) > self.model.childNumStr.integerValue){
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }
        //回调回去当前的价格
        self.adultReduce([self judgeThePriceOfUsedRoom:self.model]);
    }

}
//儿童减号
- (IBAction)childReduceBtnClick:(UIButton *)sender {
//    self.childReduce();
    if (self.model.childNumStr.integerValue >0) {
        NSInteger childNum = [self.model.childNumStr integerValue];
        childNum --;
        self.model.childNumStr = [NSString stringWithFormat:@"%ld",childNum];
        self.childNumLab.text = self.model.childNumStr;
        //修改当前房间剩余数
        self.stockLab.text = [NSString stringWithFormat:@"%@间",[self judgeTheStockRoomNumWith:self.model]];
        if (childNum == 0) {
            [self.child_Reduct_Btn setImage:[UIImage imageNamed:@"减少不可用"] forState:(UIControlStateNormal)];
        }
        if (childNum < self.model.adultNumStr.integerValue*(self.model.num.integerValue-1)){
            [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }
        if(([self.model.adultNumStr integerValue] + [self.model.childNumStr integerValue]) < (self.model.num.integerValue*self.stock.integerValue)){
            [self.adult_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }
        //回调回去当前的价格
        self.childReduce([self judgeThePriceOfUsedRoom:self.model]);
    }

}

//设置当前选中房间的价格
-(NSString*)judgeThePriceOfUsedRoom:(LLRoomDataModel*)model{
    //房间的单价
    CGFloat price = model.num.integerValue * [[self judgeThePriceOfRoomWith:model] floatValue];
    //计算当前占用的房间数目
    NSInteger roomCount = self.stock.integerValue - model.stock.integerValue;
    //总价格
    CGFloat allPrice =price * roomCount;
    return [NSString stringWithFormat:@"%.2f",allPrice];
}


//给cell赋值
-(void)setCellDataWith:(LLRoomDataModel*)model{
    //保存model
    self.model = model;
    
    //设置房间类型
    self.roomTypeLab.text = model.cabin_name;
    //设置房间信息
    self.roomInfoLab.text = [NSString stringWithFormat:@"%@㎡,%@层,入住%@人",model.size,model.floors,model.num];
    
    //剩余舱房
    self.stockLab.text = [NSString stringWithFormat:@"%@间",model.stock];
    //-------------------
    self.stock = model.stock;
    //设置价格
    self.priceLab.text = [NSString stringWithFormat:@"￥%@/人",[self judgeThePriceOfRoomWith:model]];

    
    //设置成人的人数
    self.adultNumLab.text = model.adultNumStr;
    //设置儿童的人数
    self.childNumLab.text = model.childNumStr;
    
    //总人数
    NSInteger totalNum = model.adultNumStr.integerValue + model.childNumStr.integerValue;
    //计算总人数占用的房间
    NSInteger usedRoomNum = totalNum/[self.model.num integerValue] + (totalNum%[self.model.num integerValue] >0 ? 1:0);
    if (self.stock.integerValue != usedRoomNum + self.model.stock.integerValue ) {
        //
        self.stock = [NSString stringWithFormat:@"%ld",usedRoomNum + self.model.stock.integerValue];
    }
    
        //设置成人加号图片---当前成人人数和儿童人数 小于总共能入住的人数
    if ([model.adultNumStr integerValue] + [model.childNumStr integerValue] < [model.num integerValue]* [model.stock integerValue]) {
        [self.adult_Add_Btn setImage:[UIImage imageNamed:@"添加@2x"] forState:UIControlStateNormal];
    }else{
        [self.adult_Add_Btn setImage:[UIImage imageNamed:@"添加不可用@2x"] forState:UIControlStateNormal];
    }
    //设置成人的减号图图片
    if ([model.adultNumStr integerValue] > 0) {
        [self.adult_Reduct_Btn setImage:[UIImage imageNamed:@"减少可用@2x"] forState:UIControlStateNormal];
    }else{
        [self.adult_Reduct_Btn setImage:[UIImage imageNamed:@"减少不可用@2x"] forState:UIControlStateNormal];
    }
    //设置儿童加号 ----需要满足 有成人陪同 同时还需要满足 剩余房间数可入住人数大于0
    // 房间的成人和房间的小孩 小于房间的所有入住人数  并且满足 小孩 的个人数小于大人乘以房间人数减1得值
    //当前已经选择的总人数
    NSInteger totleNum = [model.adultNumStr integerValue] + [model.childNumStr integerValue];
    //当前剩余房间数可入住的总人数
    NSInteger canSelectNum =[model.num integerValue]* [model.stock integerValue];
    //孩子的总数
    NSInteger childNum = [model.childNumStr integerValue];
    //根据当前成人数和每个房间可以入住人数 得到的可入住孩子的总数
    NSInteger childCanSelect = [model.adultNumStr integerValue] * ([model.num integerValue] - 1);
    //------此时孩子的加号是可以添加的.........
    if ((( totleNum < canSelectNum) && childNum < childCanSelect) || (totalNum % model.num.integerValue >0)) {
        [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    }else{
        [self.child_Add_Btn setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
    }
    //设置儿童减少的按钮
    if ([model.childNumStr integerValue]>0) {
        [self.child_Reduct_Btn setImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
    }else{
        [self.child_Reduct_Btn setImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
    }
       
}

#pragma mark--------显示房间价格----
//--------
-(NSString *)judgeThePriceOfRoomWith:(LLRoomDataModel*)model{
    //判断如果second_price 为0的时候 取出显示的价格为second_price_basic  如果两个都为0 取出显示价格为first_price
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
    NSInteger total = [model.adultNumStr integerValue] + [model.childNumStr integerValue];
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
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
