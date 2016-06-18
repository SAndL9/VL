//
//  LLFillOrderCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/16.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLRoomDataModel.h"
@interface LLFillOrderCell : UITableViewCell
//房间类型
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLab;
//价格
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
//房间信息
@property (weak, nonatomic) IBOutlet UILabel *roomInfoLab;
//剩余房间数目
@property (weak, nonatomic) IBOutlet UILabel *stockLab;


//成人加减按钮
@property (weak, nonatomic) IBOutlet UIButton *adult_Reduct_Btn;//减
@property (weak, nonatomic) IBOutlet UIButton *adult_Add_Btn;//加

//儿童加减按钮
@property (weak, nonatomic) IBOutlet UIButton *child_Reduct_Btn;//减
@property (weak, nonatomic) IBOutlet UIButton *child_Add_Btn;//加

//儿童成人人数
@property (weak, nonatomic) IBOutlet UILabel *adultNumLab;//成人
@property (weak, nonatomic) IBOutlet UILabel *childNumLab;//儿童


//点击成人加号回调
@property(nonatomic,copy)void(^adultAdd)(NSString*price);
//点击成人减
@property(nonatomic,copy)void(^adultReduce)(NSString*price);

//点击儿童加号
@property(nonatomic,copy)void(^childAdd)(NSString*price);
//点击儿童减号
@property(nonatomic,copy)void(^childReduce)(NSString*price);





//给cell赋值
-(void)setCellDataWith:(LLRoomDataModel*)model;


@end
