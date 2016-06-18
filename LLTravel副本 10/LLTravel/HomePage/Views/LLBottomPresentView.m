//
//  LLBottomPresentView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/13.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBottomPresentView.h"

@implementation LLBottomPresentView


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //布局
        [self SetUpAddSubViews];
    }
    return self;
}
-(void)SetUpAddSubViews{
    CGFloat width = (size_width - 10 * 2) /2;
    

    
    self.IconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 80)];
    self.IconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_IconImageView];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_IconImageView.frame), width, 40)];
    _nameLab.numberOfLines = 0;
    _nameLab.backgroundColor = [UIColor orangeColor];
    [self addSubview:_nameLab];
    
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLab.frame),width , 30)];
    _priceLab.backgroundColor = [UIColor blueColor];
    [self addSubview:_priceLab];
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
