//
//  StudentResult.h
//  HomeworkDemo
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentResult : NSObject

@property (nonatomic, assign)    int64_t     serialId;
@property (nonatomic, copy)      NSString    *name;
@property (nonatomic, copy)      NSString    *course;
@property (nonatomic, copy)    NSString    *score;

@end
