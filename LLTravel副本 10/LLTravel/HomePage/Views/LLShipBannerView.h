//
//  LLShipBannerView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLShipBannerView : UIView
//航线属性
@property (weak, nonatomic) IBOutlet UILabel *LineLab;
//出发地
@property (weak, nonatomic) IBOutlet UILabel *portLab;



-(instancetype)initWithFrame:(CGRect)frame;
@end
