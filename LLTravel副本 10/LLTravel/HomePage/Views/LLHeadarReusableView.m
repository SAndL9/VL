//
//  LLHeadarReusableView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLHeadarReusableView.h"

@implementation LLHeadarReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.sectionHeadarView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size_width, self.frame.size.height)];
        _sectionHeadarView.backgroundColor = [UIColor redColor];
        [self addSubview:_sectionHeadarView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
