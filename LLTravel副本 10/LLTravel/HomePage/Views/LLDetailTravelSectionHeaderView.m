//
//  LLDetailTravelSectionHeaderView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#define kRouteButton_Tag 10001
#define kProductFeaturesButton_Tag 10002
#define kLineView_Tag 10003

#import "LLDetailTravelSectionHeaderView.h"

@interface LLDetailTravelSectionHeaderView ()
@property(nonatomic,assign)NSInteger lastSelectButtonTag;//存放上次点击的button的tag值

@end

@implementation LLDetailTravelSectionHeaderView

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //布局
        [self loadSubVies];
    }
    return self;
}

-(void)loadSubVies{
    CGFloat WIDTH = self.frame.size.width / 2;
    UIButton *routeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    routeButton.frame = CGRectMake(0, 0,WIDTH , 35);
    [routeButton setTitle:@"行程介绍" forState:UIControlStateNormal];
    [routeButton setTag:kRouteButton_Tag];
    _lastSelectButtonTag = kRouteButton_Tag;
    [routeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [routeButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:routeButton];
    
    UIButton *ProductFeaturesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ProductFeaturesButton.frame = CGRectMake(WIDTH, 0, WIDTH, 35);
    [ProductFeaturesButton setTag:kProductFeaturesButton_Tag];
    [ProductFeaturesButton setTitle:@"产品特色" forState:UIControlStateNormal];
    [ProductFeaturesButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ProductFeaturesButton];
    
    
    //创建跟随按钮点移动的横线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, self.frame.size.height + 2, WIDTH - 20 - 10  , 2)];
    lineView.backgroundColor = [UIColor orangeColor];
    lineView.tag = kLineView_Tag;
    [self addSubview:lineView];

    
    
}

#pragma mark ----button点击事件
-(void)ClickButton:(UIButton *)sender{
    //单选效果
    NSInteger tag = sender.tag;
    //找到上次被点击的按钮 改变它的titleColor
    UIButton *lastSelectButton = [self viewWithTag:self.lastSelectButtonTag];
    [lastSelectButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    //设置当前的被选中的按钮颜色
    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //更新选中的按钮的tag值
    self.lastSelectButtonTag = tag;
    
    NSLog(@"点击的按钮是%ld......",tag);
    
    //实现横线跟随button移动
    UIView *lineView = [self viewWithTag:kLineView_Tag];
    //设置UIView动画
    [UIView animateWithDuration:0.5 animations:^{
        lineView.frame = CGRectMake(sender.frame.origin.x, lineView.frame.origin.y, lineView.frame.size.width , lineView.frame.size.height);
    }];
    
    
    //通知代理对象执行代理方法
    //判断是否 能执行方法.......
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClick:)]) {
        [self.delegate buttonClick:sender.tag];
    }
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
