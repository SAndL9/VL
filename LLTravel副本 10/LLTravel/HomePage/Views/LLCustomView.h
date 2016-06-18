//
//  LLCustomView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCustomView : UIView


//声明一个点击button的block 回调 --- 通过回调button的数标来 进行点击页面间的跳转
@property(nonatomic,copy)void(^buttonClick)(NSInteger index);

//邮轮航线的单击跳转
@property(nonatomic,copy)void(^ShipLineButtonClick)(NSInteger index);

//声明自定义的滚动视图  传入动态要显示的button文字和 Image
-(instancetype)initWithFrame:(CGRect)frame WithTitleArray:(NSArray*)titleArray imageArray:(NSArray*)imageArray;



#pragma mark ------2级页面------
//初始化邮轮界面的航线模块
-(instancetype)initWithFrame:(CGRect)frame WithDataArray:(NSArray*)dataArray;
@end
