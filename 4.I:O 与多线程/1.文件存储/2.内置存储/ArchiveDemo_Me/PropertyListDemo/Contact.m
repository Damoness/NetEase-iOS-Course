//
//  Contact.m
//  PropertyListDemo
//
//  Created by 吴狄 on 2017/7/12.
//  Copyright © 2017年 NetEase. All rights reserved.
//

#import "Contact.h"

@implementation Contact



- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];

    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder // NS_DESIGNATED_INITIALIZER
{
    
    self = [super init];
    
    if (self) {
        
        _name = [aDecoder decodeObjectForKey:@"name"];
        _mobile = [aDecoder decodeObjectForKey:@"mobile"];

    }
    
    return self;
    
    
    
}




@end
