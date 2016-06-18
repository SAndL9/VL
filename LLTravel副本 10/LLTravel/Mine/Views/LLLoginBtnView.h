//
//  LLLoginBtnView.h
//  LLTravel
//
//  Created by lanouhn on 16/6/16.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLLoginBtnView : UIView

@property(nonatomic,copy)void(^buttonClick)(NSInteger index);
@property(nonatomic,strong)UITextField *MobileTF;
@property(nonatomic,strong)UITextField *PassTF;

@property(nonatomic,strong)UIButton *WXbtn;
@property(nonatomic,strong)UIButton *QQbtn;

@end
