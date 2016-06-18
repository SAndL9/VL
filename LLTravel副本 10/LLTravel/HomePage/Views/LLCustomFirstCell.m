//
//  LLCustomFirstCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLCustomFirstCell.h"

@implementation LLCustomFirstCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 35, 35)];
        [self addSubview:_iconImg];
        
        _LocationLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImg.frame)+5, 0, self.frame.size.width - CGRectGetMaxX(_iconImg.frame) - 5, self.frame.size.height)];
        [self addSubview:_LocationLab];
        _LocationLab.backgroundColor = [UIColor blueColor];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

@end
