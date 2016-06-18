//
//  LLCustItemCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLCustItemCell.h"

@implementation LLCustItemCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _nameLab = [[UILabel alloc]initWithFrame:self.bounds];
        _nameLab.backgroundColor = [UIColor whiteColor];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLab];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
