//
//  LLStewardDetailViewController.h
//  LLTravel
//
//  Created by lanouhn on 16/6/7.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "ViewController.h"
@class LLStewardListModel;
@interface LLStewardDetailViewController : ViewController

//传递模型进来 实现展示图片和名字
@property(nonatomic,strong)LLStewardListModel *setDetailModel;

@end
