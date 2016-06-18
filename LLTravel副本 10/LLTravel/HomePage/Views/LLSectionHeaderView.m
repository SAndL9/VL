//
//  LLSectionHeaderView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/3.
//  Copyright © 2016年 taobao. All rights reserved.
//
//下面的按钮.......
#import "LLSectionHeaderView.h"
#define  kShipButton_Tag 111
#define kTicketButton_Tag 222
#define kStudyutton_Tag 333
#define kLineView_Tag 444

@interface LLSectionHeaderView ()

@property(nonatomic,assign)NSInteger lastSelectButtonTag;//存放上次点击的button的tag值


@end


@implementation LLSectionHeaderView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        UIButton *shipButton1 = [self CreatButtonWithType:UIButtonTypeCustom WithFrame:CGRectMake(20, 0, (frame.size.width - 20 * 2) /3 , frame.size.height) Title:@"邮轮" TitleColor:[UIColor orangeColor] tag:kShipButton_Tag];
//        [self addSubview:shipButton1];
        
        self.backgroundColor = [UIColor whiteColor];
    
        
        //创建 邮轮 button
        UIButton *shipButton = [UIButton buttonWithType:UIButtonTypeCustom ];
        shipButton.frame = CGRectMake(20, 0, (frame.size.width - 20 * 2) /3 , frame.size.height);
        [shipButton setTitle:@"邮轮" forState:UIControlStateNormal];
        //设置默认当前选择中的是邮轮按钮
        [shipButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        shipButton.tag = kShipButton_Tag;
        [shipButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shipButton];
        //默认第一次进人选中的邮轮按钮
        self.lastSelectButtonTag = kShipButton_Tag;
        
        //创建门票按钮
        UIButton *ticketButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ticketButton.frame = CGRectMake(20+ (frame.size.width - 20 * 2) /3, 0, (frame.size.width - 20 * 2) /3, frame.size.height);
        [ticketButton setTitle:@"门票" forState:UIControlStateNormal];
        //设置默认
        [ticketButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        ticketButton.tag = kTicketButton_Tag;
        [ticketButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ticketButton];
        
        //创建游学门票
        UIButton *studyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        studyButton.frame = CGRectMake(2 * (frame.size.width - 20 * 2) /3 + 20, 0, (frame.size.width - 20 * 2) /3, frame.size.height);
        [studyButton setTitle:@"游学" forState:UIControlStateNormal];
        //设置默认颜色
        [studyButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        studyButton.tag = kStudyutton_Tag;
        [studyButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:studyButton];
     
        //创建跟随按钮点移动的横线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(20, frame.size.height + 1, (frame.size.width - 20 * 2) /3, 1)];
        lineView.backgroundColor = [UIColor orangeColor];
        lineView.tag = kLineView_Tag;
        [self addSubview:lineView];
        
    }
    return self;
}
//创建button
-(UIButton *)CreatButtonWithType:(UIButtonType)buttonType WithFrame:(CGRect)frame Title:(NSString*)title TitleColor:(UIColor*)titlecolor tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titlecolor forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
#pragma mark ----点击事件
-(void)ClickedButton:(UIButton*)sender{
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
        lineView.frame = CGRectMake(sender.frame.origin.x, lineView.frame.origin.y, lineView.frame.size.width, lineView.frame.size.height);
    }];
    

    //通知代理对象执行代理方法
    //判断是否 能执行方法.......
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClik:)]) {
        [self.delegate buttonClik:sender.tag];
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
