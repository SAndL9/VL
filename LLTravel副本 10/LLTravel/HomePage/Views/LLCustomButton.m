//
//  LLCustomButton.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLCustomButton.h"
#import "UIImageView+WebCache.h"

@implementation LLCustomButton


//声明自定义button,传入button名字 和 标题
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString*)imageName{
    
    if (self = [super initWithFrame:frame]) {
        //社会image的大小 宽度和高度都为当前button的宽度.
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:imageView];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(-15, frame.size.width + 15, frame.size.width + 30, 15)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:titleLabel];
        
        
        
    }
    return self;
}


//创建带网络图片路径的button
-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString*)title imageUrl:(NSString *)imgUrlStr{
    if (self = [super initWithFrame:frame]) {
        
        //设置 image的大小 宽度和高度都为当前button的宽度.
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        
        [imageView  sd_setImageWithURL:[NSURL URLWithString:imgUrlStr]];
        [self addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(-15, frame.size.width + 15, frame.size.width + 30, 15)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:titleLabel];
 
        
    }
    return self;
    
    }


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
