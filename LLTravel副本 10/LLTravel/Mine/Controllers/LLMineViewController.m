//
//  LLMineViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLMineViewController.h"
#import "LLUserDefaults.h"
#import "LLLoginDataModel.h"
#import "LLLoginViewController.h"
#import "UIImageView+WebCaChe.h"
#import "LLClearCaCheCell.h"
#import "LLAboutMeViewController.h"


static NSString * cellID = @"cellid";
#define kImageCount 5
@interface LLMineViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tabbleView;

//分区数据源
@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)UIImageView *backImage;

@property(nonatomic,strong)UIButton *LogButton;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *IcomImageView;
@property(nonatomic,strong)UILabel *idNameLab;

@property(nonatomic,strong)UIButton *CleanBtn;


//接收 请求到的数据
@property(nonatomic,strong)LLLoginDataModel *model;

@end

@implementation LLMineViewController
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
        //数据源显示
        self.dataSource = [NSMutableArray arrayWithObjects:@"我的收藏",@"常用游客资料",@"我的旅历",@"个人资料",@"修改密码",@"清理缓存",@"帮助中心",@"关于微旅", nil];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabbleView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tabbleView];
    
    //注册cell
    [self.tabbleView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.tabbleView registerNib:[UINib nibWithNibName:@"LLClearCaCheCell" bundle:nil] forCellReuseIdentifier:@"LLClearCaCheCell"];
    
    self.tabbleView.dataSource = self;
    self.tabbleView.delegate   = self;
    
    [self set_backImage];
  
    if ([LLUserDefaults isLogin]) {
        _LogButton.hidden = NO;
        _nameLabel.hidden = NO;
        _idNameLab.hidden = YES;
        _CleanBtn.hidden = YES;
        _IcomImageView.hidden = YES;
    }
}


//设置表头
 -(void)set_backImage{
     // 设置背景......
     self.backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_background@2x"]];
     _backImage.frame = CGRectMake(0, 0, size_width, 150);
     self.tabbleView.tableHeaderView = self.backImage;
     
     //打开交互
     _backImage.userInteractionEnabled = YES;
     
     self.LogButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _LogButton.frame = CGRectMake((size_width - 100 )/2, (_backImage.frame.size.height - 30 ) / 2, 100, 30);
     [_LogButton setImage:[UIImage imageNamed:@"green_Btn@2x"] forState:UIControlStateNormal];
//     [LogButton setTitle:@"注册/登录" forState:UIControlStateNormal];
//     LogButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//     LogButton.titleLabel.font = [UIFont systemFontOfSize:14];
     [_LogButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [_backImage addSubview:_LogButton];
     [_LogButton addTarget:self action:@selector(LogInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     
//
     self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
     _nameLabel.text = @"注册/登陆";
     _nameLabel.textAlignment = NSTextAlignmentCenter;
     _nameLabel.font = [UIFont systemFontOfSize:15];
     _nameLabel.textColor = [UIColor whiteColor];
     [_LogButton addSubview:_nameLabel];
     
     
     
     //---------------
     self.IcomImageView = [[UIImageView alloc]initWithFrame:CGRectMake((size_width - 90 ) / 2, (_backImage.frame.size.height - 90) /2, 90, 90)];
     self.IcomImageView.layer.cornerRadius = 90 / 2;
     self.IcomImageView.layer.masksToBounds = YES;
     
     [_backImage addSubview:_IcomImageView];

     _LogButton.hidden = NO;
     _nameLabel.hidden = NO;
    //隐藏
     _IcomImageView.hidden = YES;
    
     //-------Lab
     self.idNameLab = [[UILabel alloc]initWithFrame:CGRectMake((size_width - 90 ) / 2, CGRectGetMaxY(_IcomImageView.frame) + 10, 90, 25)];
     _idNameLab.textAlignment = NSTextAlignmentCenter;
     _idNameLab.font = [UIFont systemFontOfSize:14];
     [_backImage addSubview:_idNameLab];
     //隐藏
     _idNameLab.hidden = YES;
     
 
     //---------f尾部
     self.CleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     self.CleanBtn.frame = CGRectMake(0, 0, size_width, 45);
     _CleanBtn.backgroundColor = [UIColor orangeColor];
     [_CleanBtn setTitle:@"退出登录" forState:UIControlStateNormal];
     [_CleanBtn addTarget:self action:@selector(CleanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     self.tabbleView.tableFooterView = _CleanBtn;
     
     _CleanBtn.hidden = YES;
     
 }
 #pragma mark ---  登陆按钮/
 -(void)LogInButtonClick:(id *)sender{
     NSLog(@"登陆按钮.....");
     LLLoginViewController *LoginVC = [[LLLoginViewController alloc]init];
     LoginVC.myBlock=^{
         if ([LLUserDefaults isLogin]) {
             
             self.model = [LLUserDefaults getUserInfo];
             
             _IcomImageView.hidden = NO;
             NSString *avaterStr = [NSString stringWithFormat:@"%@%@",URL_Base,[LLUserDefaults getUserInfo].avater];
             NSLog(@"-----%@",avaterStr);
            
             [_IcomImageView sd_setImageWithURL:[NSURL URLWithString:avaterStr] placeholderImage:[UIImage imageNamed:@"默认图2@2x 2"]];
             _LogButton.hidden = YES;
             _nameLabel.hidden = YES;
             _idNameLab.hidden = NO;
             _CleanBtn.hidden = NO;
             _idNameLab.text = [LLUserDefaults getUserInfo].realname;
         }

     };
     //登陆---
     LoginVC.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:LoginVC animated:YES];
 }
#pragma mark ------清除按钮
-(void)CleanBtnClick:(UIButton *)sender{
    NSLog(@"开始清除......");
    LLUserDefaults *ll = [[LLUserDefaults alloc]init];
    [ll clearUserData];
    _IcomImageView.hidden = YES;
    _CleanBtn.hidden = YES;
    _idNameLab.hidden = YES;
    _nameLabel.hidden = NO;
    _LogButton.hidden = NO;
    
}



#pragma mark - UITableViewDataSource ---- UITableViewDelegate-----
//多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//分区多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return kImageCount;
            break;
            
        default:
            return 3;
            break;
    }
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
   
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0 && indexPath.row <= 4) {
        cell.textLabel.text = self.dataSource[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    }else if (indexPath.section == 1 && indexPath.row == 0 ){
        LLClearCaCheCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLClearCaCheCell" forIndexPath:indexPath];
        cell.ClearCaCheLab.text = [NSString stringWithFormat:@"%.2fM",[self clearCaChe]];
        return cell;
    }
    else{
        cell.textLabel.text = self.dataSource[indexPath.row  + kImageCount];
        cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row + kImageCount]];
    }
   
    return cell;
}

//选择哪行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSLog(@"------点击了清除按钮");
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定要清除%.2f吗?",[self clearCaChe]] message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self removeCaChe];
            [self.tabbleView reloadData];
            
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:ok];
        [alertVC addAction:cancle];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else if ((indexPath.section == 0 && indexPath.row == 3) && _IcomImageView.hidden == NO ){
        LLAboutMeViewController *aboutMeVc = [[LLAboutMeViewController alloc]init];
    
        [self.navigationController   pushViewController:aboutMeVc animated:YES];
    }else{
    
        NSLog(@"%@....",[self.tabbleView cellForRowAtIndexPath:indexPath].textLabel.text);
    }
    }

#pragma mark -----清除缓存
//获取 cache文件下的 -- 并返回大小
-(float)clearCaChe{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    float fileSzie;
    if ([manager fileExistsAtPath:path]) {
        //拿到文件的数据
        NSArray *childFile = [manager subpathsAtPath:path];
        //拿到每个问价的名字 如果不想清除文件 在此判断
        for (NSString *fileName in childFile) {
            //将路径拼接在一起
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            fileSzie += [self fileSizePath:fullPath];
        }
    }
    return fileSzie;
}
//计算文件大小 并在lab上显示
-(float)fileSizePath:(NSString*)path{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:path]) {
        long long size = [fileManage attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024/1024;
    }
    return 0;
}

//清除缓存
-(void)removeCaChe{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:path]) {
        NSArray *childFile = [fileManage subpathsAtPath:path];
        //拿到每个问价的名字 如果不想清除文件 在此判断
        for (NSString *fileName in childFile) {
           //如果需要 加入条件过滤不想删除的文件
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManage removeItemAtPath:absolutePath error:nil];
        }
    }
}
-(void)didReceiveMemoryWarning {
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
