//
//  LLShipCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLShipModel.h"
#import "LLTicketModel.h"
#import "LLStudyModel.h"
@interface LLShipCell : UITableViewCell
@property(nonatomic,strong)UIImageView *iconImageView; //图片
@property(nonatomic,strong)UILabel *nameLab;//名字
@property(nonatomic,strong)UILabel *bottomLab;//下面的显示
@property(nonatomic,strong)UILabel *moneyLab;//钱


//展示cell
-(void)setUpDataModel:(LLShipModel*)model;
//展示门票cell
-(void)setUpDataTicketModel:(LLTicketModel*)model;
//展示游学
-(void)setUpDataStudyModel:(LLStudyModel *)model;
@end
