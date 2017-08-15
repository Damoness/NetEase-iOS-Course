//
//  GMDataCenter.m
//  GradeMagament
//
//  Created by Shaowei Zhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "GMDataCenter.h"

@interface GMDataCenter ()
{
    FMDatabase *_database;
}

@end

@implementation GMDataCenter

+ (instancetype)sharedInstance
{
    static GMDataCenter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self openDatabase];
    }
    
    return self;
}

- (void)openDatabase
{
    NSString *filepath = [self filepath];
    _database = [FMDatabase databaseWithPath:filepath];
    if ([_database open]) {
        if(![_database executeUpdate:@"create table if not exists gm_record(id integer primary key autoincrement,name TEXT, subject TEXT, grade REAL)"]) {
            NSLog(@"create table failed");
        }
    }
    else {
        NSLog(@"open database failed");
    }
    
    NSLog(@"%@", filepath);
}

- (NSArray *)getAllNames
{
    NSMutableArray *nameArray = [NSMutableArray array];
    FMResultSet *set = [_database executeQuery:@"select distinct name from gm_record"];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"name"];
        [nameArray addObject:name];
    }
    [set close];
    return nameArray;
}

- (NSArray *)searchNameByKeywords:(NSString *)keywords
{
    NSMutableArray *nameArray = [NSMutableArray array];
    FMResultSet *set = [_database executeQuery:@"select distinct name from gm_record where name like ?", [NSString stringWithFormat:@"%%%@%%",keywords]];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"name"];
        [nameArray addObject:name];
    }
    [set close];
    return nameArray;
}

- (NSArray *)getAllSubjects
{
    NSMutableArray *subjectArray = [NSMutableArray array];
    FMResultSet *set = [_database executeQuery:@"select distinct subject from gm_record"];
    while ([set next]) {
        NSString *subject = [set stringForColumn:@"subject"];
        [subjectArray addObject:subject];
    }
    [set close];
    return subjectArray;
}

- (NSArray *)getRecordsForName:(NSString *)name
{
    NSMutableArray *records = [NSMutableArray array];
    FMResultSet *set = [_database executeQuery:@"select * from gm_record where name=?", name];
    while ([set next]) {
        GMRecord *record = [[GMRecord alloc] init];
        record.name = [set stringForColumn:@"name"];
        record.subject = [set stringForColumn:@"subject"];
        record.grade = [set doubleForColumn:@"grade"];
        [records addObject:record];
    }
    [set close];
    return records;
}

- (NSArray *)getRecordsForSubject:(NSString *)subject
{
    NSMutableArray *records = [NSMutableArray array];
    FMResultSet *set = [_database executeQuery:@"select * from gm_record where subject=?", subject];
    while ([set next]) {
        GMRecord *record = [[GMRecord alloc] init];
        record.name = [set stringForColumn:@"name"];
        record.subject = [set stringForColumn:@"subject"];
        record.grade = [set doubleForColumn:@"grade"];
        [records addObject:record];
    }
    [set close];
    return records;
}

- (BOOL)recordExist:(GMRecord *)record {
    FMResultSet *set = [_database executeQuery:@"select * from gm_record where name=? and subject=?", record.name, record.subject];
    if ([set next]) {
        [set close];
        return YES;
    }
    else {
        [set close];
        return NO;
    }
}

- (void)insertNewRecord:(GMRecord *)record {
    NSString *sql = @"insert into gm_record (name,subject,grade) values (?,?,?)";
    if (![_database executeUpdate:sql, record.name, record.subject, [NSNumber numberWithFloat:record.grade]]) {
        NSLog(@"execute sql failed, sql:%@", sql);
    }
}

- (void)updateRecord:(GMRecord *)record {
    NSString *sql = @"update gm_record SET grade=? where name=? and subject=?";
    if (![_database executeUpdate:sql, [NSNumber numberWithFloat:record.grade], record.name, record.subject]) {
        NSLog(@"execute sql failed, sql:%@", sql);
    }
}

- (void)addRecord:(GMRecord *)record
{
    if ([self recordExist:record]) {
        [self updateRecord:record];
    }
    else {
        [self insertNewRecord:record];
    }
}

- (NSString *)filepath
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [document stringByAppendingPathComponent:@"GM.db"];
}

@end
