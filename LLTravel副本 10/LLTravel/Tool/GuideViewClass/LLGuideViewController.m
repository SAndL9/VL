//
//  LLGuideViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLGuideViewController.h"
#import "LLLauchViewController.h"


@interface LLGuideViewController ()
    //  图片
@property (weak, nonatomic) IBOutlet UIView *backView;
//设置View的宽度  然后 实现让其是屏幕的几倍  来实现  滚动图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *WidthConstraint;

@end

@implementation LLGuideViewController

#pragma mark 
-(void)updateViewConstraints{
    [super updateViewConstraints];
    //设置backView的宽度为引导页的宽度
    self.WidthConstraint.constant = size_width * self.imageArray.count;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSArray array];
    
    // Do any additional setup after loading the view from its nib.
    
    for (int  i = 0; i <self.imageArray.count ; i++) {
        //创建引导页展示的imageView
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(size_width * i, 0, size_width, size_height)];
        //设置imageView的图片
        [imageView setImage:[UIImage imageNamed:self.imageArray[i]]];
        //打开交换
        imageView.userInteractionEnabled = YES;
        [self.backView addSubview:imageView];
        
        //判断当前引导页是不是最后一页  添加一个按钮
        if (i == self.imageArray.count - 1) {
            
            UIButton *enterButton = [[UIButton alloc]initWithFrame:CGRectMake((size_width - 120 ) / 2, size_height - 40 - 50, 120, 40)];
            enterButton.backgroundColor = [UIColor redColor];
            [imageView addSubview:enterButton];
            [enterButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
}

-(void)enterButtonClick:(UIButton *)sender{
    //当用户点击进入按钮的时候，将启动动画设置成当前应用的住Window的rootViewController
    
    LLLauchViewController *lanchVC = [[LLLauchViewController alloc]init];
    //获得当前应用的主Window,并将lanchVc设置成ROOTviewcontroller 
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = lanchVC;
    
    
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
