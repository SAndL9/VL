//
//  LLCustomButton.h
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCustomButton : UIButton

//声明自定义button,传入button名字 和 标题
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString*)imageName;

#pragma mark  ---2级页面
//创建带网络图片路径的button
-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString*)title imageUrl:(NSString *)imgUrlStr;


@end
