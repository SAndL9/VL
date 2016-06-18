//
//  CalenderCell.h
//  VTravel
//
//  Created by zhangmeng on 16/6/12.
//  Copyright © 2016年 Lanou. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CalenderCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel; //显示日期的label
@property (weak, nonatomic) IBOutlet UIImageView *signImageView; //显示标记的图片

@end
