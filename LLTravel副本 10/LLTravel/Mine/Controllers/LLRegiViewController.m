//
//  LLRegiViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/16.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLRegiViewController.h"

@interface LLRegiViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobilTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;

@end

@implementation LLRegiViewController
- (IBAction)LoginAndRegistered:(UIButton *)sender {
    NSLog(@"注册按钮被点了.....");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self loadSubViews];
}
#pragma mark ------
-(void)loadSubViews{

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回登录按钮" style: UIBarButtonItemStyleDone target:self action:@selector(BackLogBarButton:)];
    
    
    UIImageView *Mobleimage = (UIImageView *)[self loadTFSubViewsWithimage:@"登录注册手机号"];
    _mobilTF.leftView = Mobleimage;
    _mobilTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *codeImage = (UIImageView *)[self loadTFSubViewsWithimage:@"登录注册手机号"];
    _codeTF.leftView = codeImage;
    _codeTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *CodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CodeButton.frame = CGRectMake(CGRectGetMaxX(_codeTF.frame) - 75, 0, 75, 30);
    [CodeButton setTitle:@"开始发送验证" forState:UIControlStateNormal];
    CodeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [CodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CodeButton.backgroundColor = [UIColor orangeColor];
    [CodeButton addTarget:self action:@selector(CodeBttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _codeTF.rightView = CodeButton;
    _codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *passImage = (UIImageView *)[self loadTFSubViewsWithimage:@"登录注册密码"];
    _passTF.leftView = passImage;
    _passTF.leftViewMode = UITextFieldViewModeAlways;

    
    
    
}



-(UIView *)loadTFSubViewsWithimage:(NSString*)imageName {
    UIImageView *Mobleimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    Mobleimage.image = [UIImage imageNamed:imageName];
    Mobleimage.backgroundColor = [UIColor redColor];
    return Mobleimage;
}
#pragma mark ----
-(void)CodeBttonAction:(UIButton *)sender{
    NSLog(@"开始发送验证短信......");
}
#pragma mark ---
-(void)BackLogBarButton:(UIBarButtonItem *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)loadData{
    
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
