//
//  LLTravelCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/9.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLTravelModel.h"
@interface LLTravelCell : UITableViewCell

@property(nonatomic,strong)UIImageView *backImageView; //背景图片
@property(nonatomic,strong)UILabel *nameLab; //名字
@property(nonatomic,strong)UILabel *priceLab; // 价格
@property(nonatomic,strong)UILabel *buyLab;//抢购
@property(nonatomic,strong)UILabel *tag_nameLab;//类型
//给cell上赋值
-(void)setUpCellWithModel:(LLTravelModel*)model;

@end
