//
//  LLContactCell.h
//  LLTravel
//
//  Created by lanouhn on 16/6/16.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *contactTextField;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

//点击常用联系人的回调方法
@property(nonatomic,copy)void(^buttonClick)();


@end
