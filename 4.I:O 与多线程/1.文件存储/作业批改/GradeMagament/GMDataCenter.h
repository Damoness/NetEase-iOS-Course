//
//  GMDataCenter.h
//  GradeMagament
//
//  Created by Shaowei Zhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "fmdb/FMDB.h"
#import "GMRecord.h"

@interface GMDataCenter : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getAllNames;
- (NSArray *)searchNameByKeywords:(NSString *)keywords;
- (NSArray *)getAllSubjects;
- (NSArray *)getRecordsForName:(NSString *)name;
- (NSArray *)getRecordsForSubject:(NSString *)subject;
- (void)addRecord:(GMRecord *)record;

@end
