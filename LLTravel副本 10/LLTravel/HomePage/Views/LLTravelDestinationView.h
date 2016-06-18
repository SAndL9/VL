//
//  LLTravelDestinationView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/3.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class LLTravelDestinationView;
//声明代理 用于点击相应的Button的回调
@protocol LLTravelDestinationViewDelegate <NSObject>

//声明两个 ---点击更多按钮回调 ----
-(void)moreButtonClicked;

//--------点击旅游景点按钮回调
-(void)sightSpotButtonClicked;


@end


@interface LLTravelDestinationView : UIView

//声明一个代理对象
@property(nonatomic,weak)id <LLTravelDestinationViewDelegate>delegate;
//覆盖label
@property (weak, nonatomic) IBOutlet UILabel *corverLabel;
//景点
@property (weak, nonatomic) IBOutlet UIButton *sightSoptButton;
//用于接收传递的数据源
@property(nonatomic,strong)NSMutableArray *dataArray;

//声明一个初始化方法
-(instancetype)initWithFrame:(CGRect)frame withDataDic:(NSDictionary*)dataDictionary;

//刷新数据源
-(void)UpDataButtonArray:(NSMutableArray*)array;

@end
