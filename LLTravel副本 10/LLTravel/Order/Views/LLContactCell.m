//
//  LLContactCell.m
//  LLTravel
//
//  Created by lanouhn on 16/6/16.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLContactCell.h"


@implementation LLContactCell
//常用联系人点击方法
- (IBAction)contactButtonClick:(UIButton *)sender {
    self.buttonClick();

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
