//
//  LLTicketSelect.m
//  LLTravel
//
//  Created by lanouhn on 16/6/18.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLTicketSelect.h"
#define kReserveBtn_Tag 1101101
#define kScenicBtn_Tag 1101102


@interface LLTicketSelect ()
@property (weak, nonatomic) IBOutlet UIButton *reserveBtn;
@property (weak, nonatomic) IBOutlet UIButton *ScenicBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView; //下划线
//左面的布局X线
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end


@implementation LLTicketSelect
//重写
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *viewArray = [[NSBundle mainBundle]loadNibNamed:@"LLTicketSelect" owner:self options:nil];
        
        self = viewArray[0];
        self.frame = frame;
        self.reserveBtn.tag = kReserveBtn_Tag;
        self.ScenicBtn.tag = kScenicBtn_Tag;
    }
    
    return self;
}


- (IBAction)ButtonClickAction:(UIButton *)sender {
    //判断当前点击的按钮是哪个
    if (sender.tag == kReserveBtn_Tag) {
        [self.reserveBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.ScenicBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //移动下面的约束线 为20 也就是默认
        self.leftConstraint.constant = 20;
        //移动划线
        [UIView animateWithDuration:0.5 animations:^{
            self.lineView.frame = CGRectMake(20, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);
        }];
    }else{
        [self.reserveBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.ScenicBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //XIB约束的时候 必须移动下划线约束
        self.leftConstraint.constant = self.ScenicBtn.frame.origin.x + 20;
        //移动下划线
        [UIView animateWithDuration:0.5 animations:^{
            self.lineView.frame = CGRectMake(self.ScenicBtn.frame.origin.x + 20, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);
            
            
        }];
        
        
    }
    
    //传值
    self.buttonClick(sender.tag);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
