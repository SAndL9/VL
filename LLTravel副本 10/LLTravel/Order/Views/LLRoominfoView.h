//
//  LLRoominfoView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/17.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLRoomDataModel.h"
@interface LLRoominfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *roomTypeLab;//房间类型
@property (weak, nonatomic) IBOutlet UIImageView *roomImageView;//房间图
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *floorLab;




//初始化方法
-(instancetype)initWithFrame:(CGRect)frame;
//更新数据
-(void)updateDataWith:(LLRoomDataModel*)model;


@end
