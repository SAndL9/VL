//
//  LLDetailTravelViewCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLDetailTravelViewModel.h"
@interface LLDetailTravelViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *iconImageView; //图片
@property(nonatomic,strong)UILabel *nameLab; //名字
@property(nonatomic,strong)UILabel *moneyLab;//价格
@property(nonatomic,strong)UILabel *typeLab; //旅游类型
@property(nonatomic,strong)UILabel *timeLab; //时间



//cell赋值
-(void)setUpCellWithModel:(LLDetailTravelViewModel *)model;
@end
