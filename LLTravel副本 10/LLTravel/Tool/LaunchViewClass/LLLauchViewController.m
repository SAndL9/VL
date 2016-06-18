//
//  LLLauchViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLLauchViewController.h"
#import "AppDelegate.h"
@interface LLLauchViewController ()

//显示上面小鸟的图片
@property (weak, nonatomic) IBOutlet UIImageView *birdImageView;
//下面的文字
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end

@implementation LLLauchViewController

#pragma mark   ----- 重写 viewDidAppear  -------目的是为了让其在显示的
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.5 animations:^{
        //sleep  函数使当前线程在内存中睡眠1s  来实现动画的停顿效果
        sleep(1);
        //小年上移动    只是改变的其frame的Y值
        self.birdImageView.frame =CGRectMake(self.birdImageView.frame.origin.x, self.birdImageView.frame.origin.y - 100, self.birdImageView.frame.size.width, self.birdImageView.frame.size.height);
        //文字下移动
        self.titleLab.frame = CGRectMake(self.titleLab.frame.origin.x , self.titleLab.frame.origin.y + 100, self.titleLab.frame.size.width , self.titleLab.frame.size.height );
        
//        self.titleLab.font = [UIFont systemFontOfSize:21];
        
    } completion:^(BOOL finished) {
        NSLog(@"动画完成...");
        //延迟2秒 进入 tabbarController
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //完成启动页面之后  获得当前应用的住Window
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            
            //获得sb中的tabbarController
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *tabBarController = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
            //设置当前的tabbarController为当前app的主Window
            keyWindow.rootViewController = tabBarController;
            
        });
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
