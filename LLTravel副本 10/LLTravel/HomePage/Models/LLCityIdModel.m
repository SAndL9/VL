//
//  LLCityIdModel.m
//  LLTravel
//
//  Created by lanouhn on 16/6/14.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLCityIdModel.h"

@implementation LLCityIdModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"prefix"]) {
        
        self.cityFirst = [[value substringToIndex:1] uppercaseString];
    }
}

@end
