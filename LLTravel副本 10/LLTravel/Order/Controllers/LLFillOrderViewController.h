//
//  LLFillOrderViewController.h
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseViewController.h"

@interface LLFillOrderViewController : LLBaseViewController

//传递邮轮详情里面的数据
@property(nonatomic,strong)NSDictionary *dataDic;
//传递点击的相应的按钮所在的cell上展示的房间类型
@property(nonatomic,copy)NSString *roomTypeStr;

@end
