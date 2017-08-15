//
//  GMRecord.m
//  GradeMagament
//
//  Created by Shaowei Zhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "GMRecord.h"


@implementation GMRecord

- (instancetype)initWithName:(NSString*)name Subject:(NSString*)subject Grade:(float)grade
{
    if (self = [super init]) {
        _name = name;
        _subject = subject;
        _grade = grade;
    }
    
    return self;
}

+ (BOOL)isValidGrade:(float)grade
{
    return (grade >=0.0001 && grade <= 100.00) ? YES : NO;
}

- (BOOL)hasPassed
{
    return _grade >= 60.00;
}

@end
