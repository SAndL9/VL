//
//  LLLoginBtnView.m
//  LLTravel
//
//  Created by lanouhn on 16/6/16.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLLoginBtnView.h"

#define kMemberButton_Tag 100111
#define kStewardButton_Tag 100222
#define kLOGButton_Tag 100666
#define kLineView_Tag 100333
#define kWXbutton_Tag 100777
#define kQQbutton_Tag 100888

@interface LLLoginBtnView()
@property(nonatomic,assign)NSInteger lastSelectButtonTag;
@end


@implementation LLLoginBtnView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     //加载会员和管家的按钮
        [self loadSubView];
    }
    return self;
}

-(void)loadSubView{
 
    //创建会员按钮
    UIButton *memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    memberBtn.frame = CGRectMake(60 , 0, (self.frame.size.width - 60 * 3) /2, 35);
    [memberBtn setTitle:@"会员" forState:UIControlStateNormal];
    //设置默认
    [memberBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    memberBtn.tag = kMemberButton_Tag;
    _lastSelectButtonTag  = kMemberButton_Tag;
    [memberBtn addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:memberBtn];
    
    //创建管家
    UIButton *StewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    StewardButton.frame = CGRectMake((self.frame.size.width - 60 * 3) /2 + 60 * 2, 0, (self.frame.size.width - 60 * 3) /2, 35);
    [StewardButton setTitle:@"管家" forState:UIControlStateNormal];
    //设置默认颜色
    [StewardButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    StewardButton.tag = kStewardButton_Tag;
    [StewardButton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:StewardButton];
    
    //创建跟随按钮点移动的横线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(StewardButton.frame)+1, (self.frame.size.width - 60 * 3) / 2, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.tag = kLineView_Tag;
    [self addSubview:lineView];
    
    CGFloat Width =self.frame.size.width - 50 * 2;
    
    //手机号
    self.MobileTF = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(lineView.frame)+20, Width, 36)];
    UIImageView *iconIG = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 30, 30)];
    iconIG.image = [UIImage imageNamed:@"登录注册手机号@2x"];
    _MobileTF.placeholder =@"请输入手机号";
    [_MobileTF setLeftView:iconIG];
    _MobileTF.leftViewMode = UITextFieldViewModeAlways;
    //
    [self addSubview:_MobileTF];
    
    //-------------
    UIView *TFLineView = [[UIView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_MobileTF.frame)+1, Width, 1)];
    TFLineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:TFLineView];
    
    //-----------
    self.PassTF = [[UITextField alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_MobileTF.frame)+5, Width, 36)];
    UIImageView *PassIG = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 30, 30)];
    PassIG.image = [UIImage imageNamed:@"登录注册密码@2x"];
    _PassTF.placeholder = @"请输入密码";
    _PassTF.leftView = PassIG;
    _PassTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *PassRightIG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 30, 30)];
    PassRightIG.image = [UIImage imageNamed:@"登录注册明文密码@2x"];
    _PassTF.rightView = PassRightIG;
    _PassTF.rightViewMode =UITextFieldViewModeAlways;
    [self addSubview:_PassTF];
    
    
    //下划线
    UIView *TFLineView1 = [[UIView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_PassTF.frame)+1, Width, 1)];
    TFLineView1.backgroundColor = [UIColor whiteColor];
    [self addSubview:TFLineView1];
    
    
    UIButton *LOGbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    LOGbutton.frame = CGRectMake(50, CGRectGetMaxY(TFLineView1.frame)+20, Width, 40);
    [LOGbutton setBackgroundImage:[UIImage imageNamed:@"登录注册发送验证码@2x"] forState:UIControlStateNormal];
    LOGbutton.tag =  kLOGButton_Tag;
    [LOGbutton addTarget:self action:@selector(ClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [LOGbutton setTitle:@"登录" forState:UIControlStateNormal];
    [LOGbutton setTitleEdgeInsets:UIEdgeInsetsMake(5, (Width - 40)/2, 5, (Width - 40)/2)];
    
    
//    UIButton *LOGbutton = [self CreatButtonWithImage:[UIImage imageNamed:@"登录注册发送验证码@2x"] WithFrame:CGRectMake(50, CGRectGetMaxY(TFLineView1.frame)+20, Width, 40) Title:@"登录" tag:kLOGButton_Tag];
//    [LOGbutton setTitleEdgeInsets:UIEdgeInsetsMake(5, (Width - 40)/2, 5, (Width - 40)/2)];
    [self addSubview:LOGbutton];
    
   
    self.WXbtn = [self CreatButtonWithImage:[UIImage imageNamed:@"第三方登录微信@2x"] WithFrame:CGRectMake(60,CGRectGetMaxY(LOGbutton.frame)+ 100 , 70, 70) Title:@"微信" tag:kWXbutton_Tag];
    _WXbtn.titleEdgeInsets = UIEdgeInsetsMake(70, -70, - 10, 0);
    [self addSubview:_WXbtn];
    
    self.QQbtn = [self CreatButtonWithImage:[UIImage imageNamed:@"第三方登录QQ@2x"] WithFrame:CGRectMake(CGRectGetMaxX(_WXbtn.frame) + 60, CGRectGetMaxY(LOGbutton.frame)+ 100 , 70, 70) Title:@"QQ" tag:kQQbutton_Tag];
    _QQbtn.titleEdgeInsets = UIEdgeInsetsMake(70, -70, - 10, 0);
    [self addSubview:_QQbtn];
    
    
    
    
    
}

//创建button
-(UIButton *)CreatButtonWithImage:(UIImage *)image WithFrame:(CGRect)frame Title:(NSString*)title  tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(LoginButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark ----点击按钮的方法
-(void)ClickedButton:(UIButton *)sender{
   
    //单选效果
    NSInteger tag = sender.tag;
    //找到上次被点击的按钮 改变它的titleColor
    UIButton *lastSelectButton = [self viewWithTag:self.lastSelectButtonTag];
    [lastSelectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //设置当前的被选中的按钮颜色
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //更新选中的按钮的tag值
    self.lastSelectButtonTag = tag;
    
    NSLog(@"点击的按钮是%ld......",tag);
    
    //实现横线跟随button移动
    UIView *lineView = [self viewWithTag:kLineView_Tag];
    //设置UIView动画
    [UIView animateWithDuration:0.5 animations:^{
        lineView.frame = CGRectMake(sender.frame.origin.x, lineView.frame.origin.y, lineView.frame.size.width, lineView.frame.size.height);
    }];
    _buttonClick(sender.tag);
}



-(void)LoginButton:(UIButton *)sender{
    _buttonClick(sender.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
