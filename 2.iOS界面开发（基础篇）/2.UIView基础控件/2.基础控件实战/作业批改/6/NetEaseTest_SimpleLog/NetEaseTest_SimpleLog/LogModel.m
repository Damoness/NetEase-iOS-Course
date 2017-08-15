//
//  LogModel.m
//  NetEaseTest_SimpleLog
//
//  Created by _Sharuru on 2017/6/3.
//  Copyright © 2017年 KarinoSharuru. All rights reserved.
//

#import "LogModel.h"

@implementation LogModel

- (instancetype)initWithContent:(NSString *)content{
    if (self = [super init]) {
        _content = content;
        NSDate *date = [NSDate date];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        _time = [fmt stringFromDate:date];
    }
    return self;
}

- (CGFloat)height {
    if (!_height) {
        CGFloat textH = [self.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 46, 14.5 * 5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height;
        //[_content boundingRectWithSize:textMaxSzie options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0]} context:nil].size.height;
        _height = 8 + 15 + 5 + textH + 8;

    }
    return _height;
}

@end
