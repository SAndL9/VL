//
//  LLLoginDataModel.m
//  LLTravel
//
//  Created by lanouhn on 16/6/17.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "LLLoginDataModel.h"

@implementation LLLoginDataModel
- (void)encodeWithCoder:(NSCoder *)coder
{

    [coder encodeObject:_address forKey:@"address"];
    [coder encodeObject:_auto_token forKey:@"auto_token"];
    [coder encodeObject:_avater forKey:@"avater"];
    [coder encodeObject:_birthday forKey:@"birthday"];
    [coder encodeObject:_sex forKey:@"sex"];
    [coder encodeObject:_city forKey:@"city"];
    [coder encodeObject:_phone forKey:@"phone"];
    [coder encodeObject:_uid forKey:@"uid"];
    [coder encodeObject:_username forKey:@"username"];
    [coder encodeObject:_realname forKey:@"realname"];
    [coder encodeObject:_wx_name forKey:@"wx_name"];
    [coder encodeObject:_email forKey:@"email"];
    [coder encodeObject:_idnumber forKey:@"idnumber"];
    
}
//-(id)copyWithZone:(NSZone *)zone{
//    return ;
//}
- (instancetype)initWithCoder:(NSCoder *)coder
{

    if (self = [super init]) {
        _address = [coder decodeObjectForKey:@"address"];
        _auto_token = [coder decodeObjectForKey:@"auto_token"];
        _avater = [coder decodeObjectForKey:@"avater"];
        _birthday = [coder decodeObjectForKey:@"birthday"];
        _sex = [coder decodeObjectForKey:@"sex"];
        _city = [coder decodeObjectForKey:@"city"];
        _phone = [coder decodeObjectForKey:@"phone"];
        _uid = [coder decodeObjectForKey:@"uid"];
        _username = [coder decodeObjectForKey:@"username"];
        _realname = [coder decodeObjectForKey:@"realname"];
        _wx_name = [coder decodeObjectForKey:@"wx_name"];
        _email = [coder decodeObjectForKey:@"email"];
        _idnumber = [coder decodeObjectForKey:@"idnumber"];
    }
    return self;
}
@end
