//
//  StatisticSystem+CoreDataProperties.m
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/7.
//  Copyright © 2017年 chenzhen. All rights reserved.
//
//

#import "StatisticSystem+CoreDataProperties.h"

@implementation StatisticSystem (CoreDataProperties)

+ (NSFetchRequest<StatisticSystem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"StatisticSystem"];
}

@dynamic name;
@dynamic subject;
@dynamic achivement;

@end
