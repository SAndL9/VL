//
//  LLMorePeripheralViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/9.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLMorePeripheralViewController.h"
#import "LLNetWorkManage.h"
#import "LLMorePeripheraModel.h"
#import "LLDetailTravelViewController.h"
#import "UIImageView+WebCaChe.h"
@interface LLMorePeripheralViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionVc;
//数据源
@property(nonatomic,strong)NSMutableArray *MorePerDataSourceArray;
@end

static NSString *collectionViewCellID = @"CellID111111";

@implementation LLMorePeripheralViewController

-(NSMutableArray *)MorePerDataSourceArray{
    if (!_MorePerDataSourceArray) {
        self.MorePerDataSourceArray = [NSMutableArray array];
    }
    return _MorePerDataSourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self loadData];
    [self loadSubViews];
}

#pragma mark -------
-(void)loadSubViews{

    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"周边景点";

    
    
    //创建布局对象 UICollectionViewFolleLayout  是一个布局对象  来这是item的布局样式
    UICollectionViewFlowLayout *FlowLayout1 = [[UICollectionViewFlowLayout alloc]init];
    
    //设置item的大小
    FlowLayout1.itemSize = CGSizeMake((size_width - 15 * 3) / 2, 100);
    //设置最小列间距
    FlowLayout1.minimumInteritemSpacing = 10;
    //设置最小行间距
    FlowLayout1.minimumLineSpacing = 10;
    
 
    //设置对象
    self.collectionVc = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, size_width - 10 *2, size_height) collectionViewLayout:FlowLayout1];
    
    
    self.collectionVc.backgroundColor = [UIColor yellowColor];
    //注册cell
    [self.collectionVc registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellID];
    
    [self.view addSubview:self.collectionVc];
    
    self.collectionVc.delegate = self;
    self.collectionVc.dataSource = self;

}
#pragma mark--------

-(void)loadData{

    
    [LLNetWorkManage requestGetWithUrlStr:URL_Banner paramDict:nil finish:^(id responseObejct) {
        NSLog(@"&&&&&&&&&&%@",responseObejct);
        NSArray *ReturnArr = responseObejct;
        for (NSDictionary *dic in ReturnArr) {
            LLMorePeripheraModel   *model = [[LLMorePeripheraModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.MorePerDataSourceArray addObject:model];
            
        }
        [self.collectionVc reloadData];
        NSLog(@"^^^^^^^^^%@",self.MorePerDataSourceArray);
        
    } enError:^(NSError *error) {
        
        
    }];
    
    
    
}

#pragma mark --------UICollectionViewDataSource --- UICollectionViewDelegate----
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.MorePerDataSourceArray.count;
}
//返回item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    
    NSLog(@"((((((((((((%s",__func__);
    cell.backgroundColor = [UIColor redColor];
   
    
    
//    取出对于的模型
    LLMorePeripheraModel *model = self.MorePerDataSourceArray[indexPath.row];
    //展示的东西
    //布局上面的
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    [backImageView  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_Base,model.src]] placeholderImage:[UIImage imageNamed:@"6"]];
    [cell.contentView addSubview:backImageView];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 45, 30)];
    nameLab.text = model.title;
//    nameLab.text = @"1111111";
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:nameLab];
    
    
    
    return cell;
}
//点击对应的item 实现跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //把title  传过去 重用了 更多旅行目的地的
    LLDetailTravelViewController *detailTravelVC = [[LLDetailTravelViewController alloc]init];
    //取出对应的model对象
    LLMorePeripheraModel *model = self.MorePerDataSourceArray[indexPath.row];
    detailTravelVC.DetailTitle = model.title;
    detailTravelVC.search_type = @"1";
    detailTravelVC.city_id = @"149";
    detailTravelVC.route_type = @"-11";
    detailTravelVC.category_id = @"";
    [self.navigationController pushViewController:detailTravelVC animated:YES];
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
