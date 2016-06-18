//
//  LLStewardDetailViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/7.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLStewardDetailViewController.h"
#import "LLStewardListModel.h"
#import "UIImageView+WebCache.h"
#import "LLStewardDetailViewCell.h"
#import "LLNetWorkManage.h"

@interface LLStewardDetailViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
//标题照片
@property(nonatomic,strong)NSMutableArray *detailDataArray;
@property(nonatomic,strong)NSMutableArray *detailImageArray;


@property(nonatomic,strong) NSMutableDictionary *DataDic;

@end
static NSString *cellID = @"CELLID";
@implementation LLStewardDetailViewController
-(UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}
-(NSMutableArray *)detailDataArray{
    if (!_detailDataArray) {
        self.detailDataArray = [NSMutableArray arrayWithObjects:@"管家部落",@"精通业务",@"管家所属",@"公司地址",@"联系电话",@"个人邮箱", nil];
    }
    return _detailDataArray;
}

-(NSMutableArray *)detailImageArray{
    if (!_detailImageArray) {
        self.detailImageArray = [NSMutableArray arrayWithObjects:@"gjbl@2x",@"精通@2x",@"管家所属@2x",@"地址@2x",@"管家手机@2x",@"newEmail@2x-1", nil];
    }
    return _detailImageArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"-------%@",_setDetailModel.name);
    NSLog(@"888888888  %@",_setDetailModel.avatar);
    NSLog(@"DDDDDDD%@",_setDetailModel.assistant_id);
    
    self.DataDic = [NSMutableDictionary dictionary];
    
    //调用方法
    [self setUpSubViews];
    [self loadData];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}

-(void)setUpSubViews{
    
     self.navigationItem.title =_setDetailModel.name;
    
    //注册cell

    [self.tableView registerClass:[LLStewardDetailViewCell class] forCellReuseIdentifier:cellID];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 150)];
    view.backgroundColor = [UIColor orangeColor];
    
    self.tableView.tableHeaderView = view;
    CGFloat width = 70;
    UIImageView *iconImageView  = [[UIImageView alloc]initWithFrame:CGRectMake((size_width - width ) / 2, (150 - width) / 2, width, width)];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URL_Base,_setDetailModel.avatar]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"默认图2@2x 2"]]];
    iconImageView.layer.masksToBounds = YES;
//    iconImageView.layer.
   

    NSLog(@"%@",iconImageView.image);
    [view addSubview:iconImageView];
    
    UIView *FootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size_width, 200)];
    self.tableView.tableFooterView =FootView;
    

    UIButton *bindingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bindingButton.frame = CGRectMake(10,  35, (size_width - 10 * 3) / 2, 40);
    [bindingButton setTag:1000001];
    [bindingButton setImage:[UIImage imageNamed:@"绑定@2x"] forState:UIControlStateNormal];
    [bindingButton addTarget:self action:@selector(BindingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [FootView addSubview:bindingButton];
    
    UIButton *consultingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    consultingButton.frame = CGRectMake(10 * 2 + (size_width - 10 * 3) / 2 , 35, (size_width - 10 * 3) / 2, 40);
    [consultingButton setTag:1000002];
    [consultingButton setImage:[UIImage imageNamed:@"咨询@2x"] forState:UIControlStateNormal];
    [consultingButton addTarget:self action:@selector(BindingButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [FootView addSubview:consultingButton];
    
    
}
//请求数据
-(void)loadData{
    
    [self.DataDic removeAllObjects];
    [LLNetWorkManage requestGetWithUrlStr:[NSString stringWithFormat:@"%@/%@",URL_StewardDetail,_setDetailModel.assistant_id] paramDict:nil finish:^(id responseObejct) {
        NSLog(@"1111111111%@",responseObejct);
//        NSMutableDictionary *tempdic = [NSMutableDictionary dictionary];
        NSDictionary *dic = responseObejct[@"data"];
       
        
        [self.DataDic setValue:[dic objectForKey:@"mobile"] forKey:@"mobile"];
        NSArray *array = [dic objectForKey:@"sellers"];
        for (NSDictionary *dict in array) {
            
            [self.DataDic setValue:[dict objectForKey:@"name"] forKey:@"name"];
            [self.DataDic setValue:[dict objectForKey:@"address"] forKey:@"address"];
        }
        
        [self.tableView reloadData];
        
        NSLog(@"mobile ====== %@ ",[self.DataDic objectForKey:@"mobile"]);
            NSLog(@"name ====== %@ ",[self.DataDic objectForKey:@"name"]);
      
            NSLog(@"name ====== %@ ",[self.DataDic objectForKey:@"address"]);
        
    } enError:^(NSError *error) {
        
        
    }];
}

#pragma mark -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLStewardDetailViewCell *cell = [[LLStewardDetailViewCell alloc]init];
    cell.iconImageView.image = [UIImage imageNamed:self.detailImageArray[indexPath.row]];
    cell.nameLab.text = self.detailDataArray[indexPath.row];
  
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 2) {
        cell.detailLab.text = [self.DataDic objectForKey:@"name"];
    }
    if (indexPath.row == 3) {
        cell.detailLab.text = [self.DataDic objectForKey:@"address"];
    }
    if (indexPath.row == 4) {
        cell.detailLab.text = [self.DataDic objectForKey:@"mobile"];
    }
    
    
    return cell;
}
#pragma mark ------- buttonClick:
-(void)BindingButton:(UIButton*)sender{
    switch (sender.tag) {
        case 1000001:
            NSLog(@"绑定被点击了.....");
            break;
        case 1000002:
            NSLog(@"咨询被点击了.....");
            break;
        default:
            break;
    }
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
