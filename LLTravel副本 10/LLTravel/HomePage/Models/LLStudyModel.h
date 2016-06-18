//
//  LLStudyModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLStudyModel : LLBaseModel
@property(nonatomic,copy)NSString *name;//名字
@property(nonatomic,copy)NSString *thumb;//图片
@property(nonatomic,copy)NSString *setoff_date;//日期
@property(nonatomic,copy)NSString *camper_price;//钱

@end
