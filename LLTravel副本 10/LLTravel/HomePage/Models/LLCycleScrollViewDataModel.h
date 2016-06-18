//
//  LLCycleScrollViewDataModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/3.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLCycleScrollViewDataModel : LLBaseModel

@property(nonatomic,copy)NSString *src; //图片路径
@property(nonatomic,copy)NSString *link;//点击图片跳转路径

@property(nonatomic,copy)NSString *goto_;//轮播图上跳转到详情参数


@end
