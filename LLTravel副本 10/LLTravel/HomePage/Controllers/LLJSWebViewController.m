//
//  LLJSWebViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/5.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLJSWebViewController.h"

@interface LLJSWebViewController ()

@end

@implementation LLJSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
     UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.Webmodel.link]]];
    [self.view addSubview:webview];
    //-----------需要传递标题--------------
    self.navigationItem.title = @"推荐景点";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<首页" style:UIBarButtonItemStylePlain target:self action:@selector(PoPHome:)];
}

#pragma mark ---------- 返回首页
-(void)PoPHome:(UIBarButtonItem *)sender{
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
