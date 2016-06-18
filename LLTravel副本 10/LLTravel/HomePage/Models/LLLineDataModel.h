//
//  LLLineDataModel.h
//  LLTravel
//
//  Created by lanouhn on 16/6/7.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLLineDataModel : LLBaseModel
//航线模型
@property(nonatomic,copy)NSString *line_id;//航线id
@property(nonatomic,copy)NSString *line_name; //航线名字
@property(nonatomic,copy)NSString *pic;//图片URL
@end
