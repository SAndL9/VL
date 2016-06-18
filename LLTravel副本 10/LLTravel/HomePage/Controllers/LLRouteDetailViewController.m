//
//  LLRouteDetailViewController.m
//  LLTravel
//
//  Created by lanouhn on 16/6/13.
//  Copyright © 2016年 taobao. All rights reserved.
//

#define kLeft_Tag 2222
#define kRight_Tag 3333

#import "LLRouteDetailViewController.h"
#import "LLDaysModel.h"
#import "LLRouteDetailDayCell.h"
#import "LLRouteDetailHeaderView.h"

@interface LLRouteDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
//YES 表示上拉  NO 表示下滑  默认就是 ;
@property(nonatomic,assign)BOOL isUP;


@end

@implementation LLRouteDetailViewController
- (IBAction)HandCancelButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置tag值
    self.leftTableView.tag = kLeft_Tag;
    self.rightTableView.tag = kRight_Tag;
    
    //注册leftcel
    [self.leftTableView registerNib:[UINib nibWithNibName:@"LLRouteDetailDayCell" bundle:nil] forCellReuseIdentifier:@"LLRouteDetailDayCell"];
    //注册表头视图
    [self.rightTableView registerNib:[UINib nibWithNibName:@"LLRouteDetailHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LLRouteDetailHeaderView"];
    
    
    //设置默认进来的时候 只能向上滚动 ----
    _isUP = YES;
    
    //设置默认选中的是第一天
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    
    
    
    
    
    
    
    //----------设置tableView的顶起显示
    self.rightTableView.separatorInset=UIEdgeInsetsZero;
    
    self.rightTableView.layoutMargins=UIEdgeInsetsZero;
    
    self.leftTableView.separatorInset=UIEdgeInsetsZero;
    
    self.leftTableView.layoutMargins=UIEdgeInsetsZero;
    
    
    //隐藏左边的滑条
    self.leftTableView.showsVerticalScrollIndicator = NO;
    
    [self loadData];
    [self loadSubVies];
    
    
    
}
#pragma mark --
-(void)loadSubVies{
    NSLog(@"days---------- %@",self.daysDataArray);
}
#pragma mark ----
-(void)loadData{
    
}

#pragma mark ----
//返回行数
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == kLeft_Tag) {
        return self.daysDataArray.count;
    }else{
        return 1;
    }
    
}
//返回分区的
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == kLeft_Tag) {
        return 1;
    }else{
       return self.daysDataArray.count;
       
    }
    
}
//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    if (tableView.tag == kLeft_Tag) {
        //返回左面的cell
        LLRouteDetailDayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLRouteDetailDayCell" forIndexPath:indexPath];
        cell.separatorInset=UIEdgeInsetsZero;
        cell.layoutMargins=UIEdgeInsetsZero;
        
            //给cell赋值
        LLDaysModel *model = self.daysDataArray[indexPath.row];
     
        
        cell.detailLab.text = [NSString stringWithFormat:@"D%@",model.day];
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

//返回分区的区头标题
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LLRouteDetailHeaderView *hearderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"LLRouteDetailHeaderView"];
    //给cell赋值
    LLDaysModel *model = self.daysDataArray[section];
    NSLog(@"-------%@",model.day);
    hearderView.rightDayLab.text = [NSString stringWithFormat:@"第%@天",model.day];
    hearderView.RouteLab.text = model.title;
    

    return hearderView;
}

//返回cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath   {
    if (tableView.tag == kLeft_Tag) {
        return 80;
    }
    return 150;
    
    
}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (tableView.tag == kLeft_Tag) {
        //点击相应的天数按钮,使右侧tableView对应的天数滚动到顶部
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
}
//区头将要出现
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    NSLog(@"-----+++-----%ld",section);
    if (!_isUP) {
        if (section >= self.daysDataArray.count) {
            return;
        }
        //判断下拉的时候 选中左侧相应的天数
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath  indexPathForRow:section  inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}
//区头将要消失的方法
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    NSLog(@"-------%ld-------",section);
    if (_isUP) {
        
        if (section + 1 >= self.daysDataArray.count) {
            return;
        }
        
        //判断上拉的时候
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark --------
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag == kRight_Tag) {
        
  
    //获得拖拽的时候 一个点。。。。。
    CGPoint point = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
        NSLog(@"****@!!!!!!!!!%f",point.y);
    //判断是否处于滚动
    if (point.y >= 0) {
        _isUP= NO;
    }else if(point.y < 0){
        _isUP = YES;
    }
    
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
