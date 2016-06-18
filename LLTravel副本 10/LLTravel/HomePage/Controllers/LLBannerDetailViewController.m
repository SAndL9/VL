//
//  LLBannerDetailViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/6.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLBannerDetailViewController.h"

@interface LLBannerDetailViewController ()

@end

@implementation LLBannerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, size_width, 40)];
    titleLab.backgroundColor = [UIColor cyanColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:titleLab];
    titleLab.text = self.Webtitle;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLab.frame), size_width, size_height - CGRectGetMaxY(titleLab.frame))];
    
    [self.view addSubview:webView];
    
    
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
