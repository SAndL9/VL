//
//  LLPeripheralFeatureSpotView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPeripheraModel.h"
@interface LLPeripheralFeatureSpotView : UIView

//block 回调
//声明一个周边景点的block
@property(nonatomic,copy)void(^peripheralButtonClicker)(NSInteger index);
//声明一个管家的block  flag 标识
@property(nonatomic,copy)void(^stewardButtonClicked)(NSInteger flag);

//更多按钮的回调
@property(nonatomic,copy)void(^moreButtonClicker)(NSInteger flag);

//用于接收从外面传递的对象
@property(nonatomic,strong)NSArray *perArray;

////model 对象
//@property(nonatomic,strong)LLPeripheraModel *perModel;

//初始化方法
//声明初始化周边景点视图
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray*)dataArray;




//刷新数据源
-(void)UpDataButtonArray:(NSMutableArray*)array;

@end
