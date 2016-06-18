//
//  LLShipSelectHeaderView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/12.
//  Copyright © 2016年 taobao. All rights reserved.
//

#define kSummaryButton_Tag 111
#define kRouteButton_Tag 222
#import "LLShipSelectHeaderView.h"

@interface LLShipSelectHeaderView ()
//概述按钮
@property (weak, nonatomic) IBOutlet UIButton *summaryButton;
//行程按钮
@property (weak, nonatomic) IBOutlet UIButton *routeButton;
    //划线属性
@property (weak, nonatomic) IBOutlet UIView *lineView;
//划线的布局x属性
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end


@implementation LLShipSelectHeaderView

//重写
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *viewArray = [[NSBundle mainBundle]loadNibNamed:@"LLShipSelectHeaderView" owner:self options:nil];
    
        self = viewArray[0];
            self.frame = frame;
        self.summaryButton.tag = kSummaryButton_Tag;
        self.routeButton.tag = kRouteButton_Tag;
    }
    
    return self;
}

#pragma mark-----button的点击事件
- (IBAction)clickerTheButton:(UIButton *)sender {
    //判断当前点击的按钮是哪个
    if (sender.tag == kSummaryButton_Tag) {
        [self.summaryButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.routeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //移动下面的约束线 为20 也就是默认
        self.leftConstraint.constant = 20;
        //移动划线
        [UIView animateWithDuration:0.5 animations:^{
            self.lineView.frame = CGRectMake(20, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);
        }];
    }else{
        [self.routeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.summaryButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //XIB约束的时候 必须移动下划线约束
        self.leftConstraint.constant = self.routeButton.frame.origin.x;
        //移动下划线
        [UIView animateWithDuration:0.5 animations:^{
            self.lineView.frame = CGRectMake(self.routeButton.frame.origin.x, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);

            
        }];
        
        
    }
    
    //传值
    self.buttonClick(sender.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
