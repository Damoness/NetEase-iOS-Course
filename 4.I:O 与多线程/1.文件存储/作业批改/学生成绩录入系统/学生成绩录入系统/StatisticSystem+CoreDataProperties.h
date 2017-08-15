//
//  StatisticSystem+CoreDataProperties.h
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/7.
//  Copyright © 2017年 chenzhen. All rights reserved.
//
//

#import "StatisticSystem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StatisticSystem (CoreDataProperties)

+ (NSFetchRequest<StatisticSystem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *subject;
@property (nonatomic) NSString *achivement;

@end

NS_ASSUME_NONNULL_END
