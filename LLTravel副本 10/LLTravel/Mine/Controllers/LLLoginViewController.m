//
//  LLLoginViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLLoginViewController.h"
#import "LLLoginBtnView.h"
#import "LLRegiViewController.h"
#import "LLNetWorkManage.h"
#import "LLLoginDataModel.h"
#import "LLUserDefaults.h"

#import "LLMineViewController.h"


#define kMemberButton_Tag 100111
#define kStewardButton_Tag 100222
#define kLineView_Tag 100333
#define kMobilTF_Tag 100444
#define kPassTF_Tag 100555
#define kLOGButton_Tag 100666
#define kWXbutton_Tag 100777
#define kQQbutton_Tag 100888



@interface LLLoginViewController ()<UITextFieldDelegate>

@end

@implementation LLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor  whiteColor];
    UIImageView *backgroudImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgroudImage.image = [UIImage imageNamed:@"登录注册页面背景@2x"];
    backgroudImage.userInteractionEnabled = YES;
    [self.view addSubview:backgroudImage];
    
    [self loadData];
    [self loadSubViews];
    
    
}
#pragma mark -------加载数据
-(void)loadData{
    
   
    
    
    
    
}
#pragma makr--------
-(void)loadSubViews{
    self.title = @"会员登录";
    [self LoginBarButton];
    
    CGFloat W = 90;
    UIImageView *IconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((size_width - W ) / 2, 64 + 15, W, W)];
    IconImageView.backgroundColor = [UIColor redColor];
    IconImageView.image = [UIImage imageNamed:@"login_reg_logo@2x"];
    [self.view addSubview:IconImageView];
    
    LLLoginBtnView *BtnVc = [[LLLoginBtnView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(IconImageView.frame), size_width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(BtnVc.frame))];
    [self.view addSubview:BtnVc];


    BtnVc.buttonClick =^(NSInteger index){
        switch (index) {
            case kMemberButton_Tag:
                NSLog(@"点击了会员的按钮。。。。。。。");
                [self LoginBarButton];
                BtnVc.WXbtn.alpha = 1;
                BtnVc.QQbtn.alpha = 1;
                break;
               case kStewardButton_Tag:
                NSLog(@"点击了管家按钮......");
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]init];
                BtnVc.WXbtn.alpha = 0;
                BtnVc.QQbtn.alpha = 0;
                break;
            case kLOGButton_Tag:{
                NSLog(@"点击了登录按钮....");
               
                
                [self showHUDWith:@"正在登录..."];
                //取出手机号

//                NSString *uesrName = BtnVc.MobileTF.text;
                NSString *uesrName = @"15090638116";
                //取出密码
//                NSString *passWord = BtnVc.PassTF.text;
                NSString *passWord = @"123456";
                //发起请求
                NSDictionary *paramDic = @{@"username":uesrName,@"password":passWord};
                [LLNetWorkManage requestPOSTWithUrlStr:URL_Login paramDict:paramDic finish:^(id responseObject) {
                    [self hidenHUD];
                    
                    if ([responseObject[@"status"] integerValue] == 1) {
                        NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
                        LLLoginDataModel *model = [[LLLoginDataModel alloc]init];
                        [model setValuesForKeysWithDictionary:dataDic];
                        //将登录成功数据存储本地
                        [LLUserDefaults saveUserInfo:model];
                        [self showAlertWith:[responseObject objectForKey:@"msg"]];
                        
                     
                        //登录成功pop回去 刷新页面
//                        [self.navigationController popToViewController:backVC animated:YES];
                        
                        
                        

                    }else{
                        
                    
                    }
                    
                    [self showAlertWith:@"登录成功!!!"];

                    self.myBlock();

                    NSLog(@"kkkkkkkkkkkkkkkkkkk---%@",responseObject);
                    
                } enError:^(NSError *error) {
                   
                    
                }];
                
                
                
                
                
            }break;
            case kWXbutton_Tag:
                NSLog(@"点击了微信按钮....");
                break;

            case kQQbutton_Tag:
                NSLog(@"点击了QQ按钮....");
                break;

            default:
                break;
        }
    };
 

    BtnVc.MobileTF.delegate = self;
    BtnVc.PassTF.delegate = self;
    
    
    
    
}
#pragma mark -------注册按钮
-(void)LoginBarButton{
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClickAction:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;

}

#pragma mark -----
//点击注册按钮的
-(void)rightBarButtonClickAction:(UIBarButtonItem *)sender{
    LLRegiViewController *RegiVC = [[LLRegiViewController alloc]init];
    [self.navigationController pushViewController:RegiVC animated:YES];
}

#pragma mark --------
/**15090638116
 * 123456
 http://www.weilv100.com/api/member/login_action
 username
 password
 
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
