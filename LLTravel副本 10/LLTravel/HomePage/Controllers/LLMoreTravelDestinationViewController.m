//
//  LLMoreTravelDestinationViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/7.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLMoreTravelDestinationViewController.h"
#import "LLNetWorkManage.h"
#import "LLMoreTravelModel.h"
#import "UIImageView+WebCaChe.h"
#import "LLDetailTravelViewController.h"
@interface LLMoreTravelDestinationViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//数据源
@property(nonatomic,strong)NSMutableArray *dataTraverArray;
@property(nonatomic,strong)UICollectionView *collectionVC;

@end
static NSString * cellID = @"cell";
@implementation LLMoreTravelDestinationViewController

-(NSMutableArray *)dataTraverArray{
    if (!_dataTraverArray) {
        self.dataTraverArray = [NSMutableArray array];
    }
    return _dataTraverArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"精选旅行目的地";
    [self loadData];
    [self loadSubViews];
    
}
//布局
-(void)loadSubViews{
    //创建布局对象 uicollectionViewFolleLayout 对象 是一个布局对象 来设置item的布局样式
    UICollectionViewFlowLayout *FlowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置item的大小
    FlowLayout.itemSize = CGSizeMake(size_width - 15 *2, 170);
    //设置最小列间距
    FlowLayout.minimumInteritemSpacing = 10;
    //设置对象
     self.collectionVC= [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:FlowLayout];
    
    self.collectionVC.delegate = self;
    self.collectionVC.dataSource = self;
    
    
    [self.collectionVC registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:self.collectionVC];
}
//加载书籍
-(void)loadData{
     NSDictionary *paramDic = @{@"city_id":@149,@"adType":@119};

    [LLNetWorkManage requestPOSTWithUrlStr:URL_MoreTravel paramDict:paramDic finish:^(id responseObject) {
         NSLog(@"***********%@",responseObject);
        NSArray *returnArr = responseObject[@"data"];
        for (NSDictionary *dic in returnArr) {
            LLMoreTravelModel *model = [[LLMoreTravelModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataTraverArray addObject:model];
        }
        [self.collectionVC reloadData];
        NSLog(@"daaaaaa-----%@",self.dataTraverArray);
       
        
    } enError:^(NSError *error) {
        
        
    }];
    
    
}
#pragma mark -------uicollectionViewDataSource-UICollection---
//返回item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataTraverArray.count;
}
//返回cell
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
 

    //-------布局 并 赋值
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    LLMoreTravelModel *model = self.dataTraverArray[indexPath.row];
    [backImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_Base,model.src]] placeholderImage:[UIImage imageNamed:@"6"]];
    [cell.contentView addSubview:backImageView];
    
 //------
        UILabel *TitleLab = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 100 ) / 2, 65, 100, 40)];
    TitleLab.text = model.title;
        TitleLab.textAlignment = NSTextAlignmentCenter;
    //设置边框是否可以切割
    //设置边框颜色
    //设置边框的宽度
    TitleLab.layer.masksToBounds = YES;
    TitleLab.layer.borderColor = [UIColor whiteColor].CGColor;
    TitleLab.layer.borderWidth = 3;
 
        [backImageView addSubview:TitleLab];
   
    

   

    return cell;
}



//选中item是触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    LLDetailTravelViewController *detailTraveVC = [[LLDetailTravelViewController alloc]init];
    LLMoreTravelModel *model = self.dataTraverArray[indexPath.row];
    NSLog(@"title  ====== %@",model.title);
    detailTraveVC.DetailTitle = model.title;
    detailTraveVC.search_type = @"1";
    detailTraveVC.city_id = @"";
    detailTraveVC.route_type = @"";
    detailTraveVC.category_id = @"";
    [self.navigationController pushViewController:detailTraveVC animated:YES];
    
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
