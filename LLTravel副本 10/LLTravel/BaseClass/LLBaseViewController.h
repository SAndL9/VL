//
//  LLBaseViewController.h
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBaseViewController : UIViewController



//显示加载圈 title为加载圈上显示的内容
-(void)showHUDWith:(NSString*)title;

//隐藏加载圈
-(void)hidenHUD;



//弹出框
-(void)showAlertWith:(NSString*)message;
@end
