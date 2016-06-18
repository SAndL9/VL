//
//  LLCityListViewController.h
//  LLTravel
//
//  Created by lanouhn on 16/6/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseViewController.h"


@interface LLCityListViewController : LLBaseViewController



@property(nonatomic,copy)NSString *currentCityStr;//用于传递首页定位到的城市


//回调回去用于展示的位置信息
@property(nonatomic,copy)void(^mySelectItemBlock)(NSString *string, NSString *product);

@end
