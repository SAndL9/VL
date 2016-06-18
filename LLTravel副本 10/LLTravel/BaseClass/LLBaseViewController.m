//
//  LLBaseViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/2.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBaseViewController.h"
#import "MBProgressHUD.h"
@interface LLBaseViewController ()

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation LLBaseViewController


#pragma mark  -------HUD--------

//显示加载圈 title为加载圈上显示的内容
-(void)showHUDWith:(NSString*)title{
    [self.hud show:YES];
    self.hud.labelText = title;
}

//隐藏加载圈
-(void)hidenHUD{
    [self.hud  hide:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化HUD
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
}

//弹出框
-(void)showAlertWith:(NSString*)message{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
