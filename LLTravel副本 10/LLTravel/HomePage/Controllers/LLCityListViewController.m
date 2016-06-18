//
//  LLCityListViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLCityListViewController.h"
#import "LLNetWorkManage.h"
#import "LLCityListViewController.h"
#import "LLCityIdModel.h"
#import "LLHeadarReusableView.h"
#import "LLCustItemCell.h"
#import "LLCustomFirstCell.h"

@interface LLCityListViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property(nonatomic,strong)UICollectionView *collectionView;


// 存放城市首字母的数组
@property(nonatomic,strong)NSMutableArray *cityPrefixArray;
// 存放城市的model的数组
@property(nonatomic,strong)NSMutableArray *cityListModel;
// 存放对应键值对的字典
@property(nonatomic,strong)NSMutableDictionary *cityListDiction;



@end
static NSString *sectionHeader =@"sectionHeader";
@implementation LLCityListViewController

- (NSMutableDictionary *)cityListDiction{
    
    if (!_cityListDiction) {
        
        self.cityListDiction = [NSMutableDictionary new];
    }
    
    return _cityListDiction;
}

-(NSMutableArray *)cityPrefixArray{
    
    if (!_cityPrefixArray) {
        
        self.cityPrefixArray = [NSMutableArray new];
    }
    
    return _cityPrefixArray;
}

- (NSMutableArray *)cityListModel{
    
    if (!_cityListModel) {
        
        self.cityListModel = [NSMutableArray new];
    }
    
    return _cityListModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    

}
#pragma mark -----
-(void)loadSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(BackBtnAction:)];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.itemSize = CGSizeMake(size_width / 5, 40);
    //设置最小列间距
    flowLayout.minimumInteritemSpacing = 1;
    //设置最小行间距
    flowLayout.minimumLineSpacing = 1;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, size_width, size_height - 64) collectionViewLayout:flowLayout];

    //注册分区
    [self.collectionView registerClass:[LLCustItemCell class] forCellWithReuseIdentifier:@"cellsection1"];
    
    //注册区头
    [self.collectionView registerClass:[LLHeadarReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeader];

    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
}
#pragma mark ---
-(void)BackBtnAction:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------
-(void)loadData{
    //请求城市列表
    [LLNetWorkManage requestGetWithUrlStr:URL_CityList paramDict:nil finish:^(id responseObejct) {
        NSLog(@"请求的城市列表成功%@",responseObejct);
        NSArray *dataArray = responseObejct[@"data"];

        NSMutableArray *listArray = [NSMutableArray new];
        
        for (NSDictionary *cityList in dataArray) {
            
            if ([cityList[@"region_type"] isEqualToString:@"3"]&& cityList[@"is_open"]) {
                
                LLCityIdModel *model = [LLCityIdModel new];
                
                [model setValuesForKeysWithDictionary:cityList];
                
                [self.cityListModel addObject:model];
                
                [listArray addObject:model.cityFirst];
                
            }
            
        }
        // 对存放手字母的数组进行排序去重
        NSSet *set = [NSSet setWithArray:listArray];
        
        self.cityPrefixArray = [NSMutableArray arrayWithArray:[set allObjects]];
        
        // NSLog(@"%@",self.cityPrefixArray);
        
        for (int i = 0; i < self.cityPrefixArray.count; i++) {
            
            NSString *key = self.cityPrefixArray[i];
            
            NSMutableArray *value = [NSMutableArray new];
            
            [self.cityListDiction setObject:value forKey:key];
            
        }
        
        //  NSLog(@"%@",self.cityListDiction);
        
        for (LLCityIdModel *model in self.cityListModel) {
            
            NSMutableArray *group = self.cityListDiction[model.cityFirst];
            
            [group addObject:model];
        }
        
        //  NSLog(@"%@",self.cityListDiction);

       
        [self loadSubViews];
        [self.collectionView reloadData];
        
    } enError:^(NSError *error) {
        
        
    }];
    
}


#pragma mark ---------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
          return self.cityPrefixArray.count;
    }else{
        NSString *key = self.cityPrefixArray[section - 2];
        
        NSArray *group = self.cityListDiction[key];
        
        return group.count;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
     return self.cityPrefixArray.count + 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     LLCustItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellsection1" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {

       
       cell.nameLab.text = self.currentCityStr;
    }else if (indexPath.section == 1){
    
        cell.nameLab.text = self.cityPrefixArray[indexPath.row];

    }else{
       
        
        //        cell.nameLab.text = @"金华";
        
        NSString *key = self.cityPrefixArray[indexPath.section - 2];
        
        NSArray *group = self.cityListDiction[key];
        
        LLCityIdModel *model = group[indexPath.row];
        
        cell.nameLab.text = model.region_name;
        
        
    }
    return cell;

    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat W =  (size_width - 4) / 5;
    return CGSizeMake(W, 45);

}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(size_width, 25);
}
// 返回页眉
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        //从缓存中获取 UICollectionReusableView
        LLHeadarReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeader forIndexPath:indexPath];
        
        if (indexPath.section == 0) {
            
            cell.sectionHeadarView.text = @"当前定位城市";
        }else if (indexPath.section == 1){
            
            cell.sectionHeadarView.text = @"快速定位";
        }else{
            
            NSString *key = self.cityPrefixArray[indexPath.section - 2];
            
            cell.sectionHeadarView.text = key;
            
        }
        
        return cell;
    }
    
    return  nil;
}
//点击item滚动到指定分区
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row + 2] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }else if (indexPath.section >= 2){
        NSLog(@"&&^^^&^^^%ld --- %ld",indexPath.section,indexPath.row);
        
        LLCustItemCell *item = (LLCustItemCell*)[collectionView cellForItemAtIndexPath:indexPath];
        NSLog(@"item=======%@",item.nameLab.text);
        
        NSString *key = self.cityPrefixArray[indexPath.section - 2];
        
        NSArray *group = self.cityListDiction[key];
        
        LLCityIdModel *model = group[indexPath.row];

        self.mySelectItemBlock(model.region_name,model.parent_id);
        [self dismissViewControllerAnimated:YES completion:nil];
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
