//
//  FillOrderCell.h
//  VTravel
//
//  Created by zhangmeng on 16/6/16.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLRoomDataModel.h"


@interface OtherFillOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *roomTypeLab; //房间类型
@property (weak, nonatomic) IBOutlet UILabel *priceLab;//单人价格
@property (weak, nonatomic) IBOutlet UILabel *roomInfoLab;//房间信息
@property (weak, nonatomic) IBOutlet UILabel *stockLab;//剩余房间数目

@property (weak, nonatomic) IBOutlet UIButton *child_Reduce_Btn;//儿童减号按钮
@property (weak, nonatomic) IBOutlet UIButton *child_Add_Btn;//儿童加号按钮
@property (weak, nonatomic) IBOutlet UILabel *childNumLab;//儿童当前数目




//点击儿童加号回调
@property (nonatomic, copy) void(^childAdd)();

//点击儿童减号
@property (nonatomic, copy) void(^childReduce)();

//给cell赋值
- (void)setCellDataWith:(LLRoomDataModel *)model;


@end
