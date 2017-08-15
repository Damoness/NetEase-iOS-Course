//
//  DatabaseManager.m
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDatabase.h"

@implementation DatabaseManager
{
    
    FMDatabase *_database;
    
}

static DatabaseManager *manager;



+(instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DatabaseManager alloc]init];
        
        [manager openDatabase];
        
    });
    
    return manager;
    
}

-(BOOL)addRecord:(Record *)record{
    
    if ([_database executeUpdate:@"insert into records (name,subject,score) values (?,?,?)",record.name,record.subject,record.score]){
        
        return true;
        
    }else{
        
        return false;
    }
    
    
}

- (NSMutableArray<Record *>*)readAllNamesByStr:(NSString *)str
{
    
    NSMutableArray *records = [NSMutableArray array];
    
    
    NSString *searchText = [NSString stringWithFormat:@"%%%@%%",str];
    
    FMResultSet *set = [_database executeQuery:@"select distinct name from records where name like ?",searchText];
    while ([set next])
    {
        Record *record =[[Record alloc] init];
        //record.serialId = [set longLongIntForColumn:@"id"];
        record.name = [set stringForColumn:@"name"];
        //record.subject = [set stringForColumn:@"subject"];
        //record.score = [set stringForColumn:@"score"];
        [records addObject:record];
    }
    [set close];
    
    return records;
}

- (NSMutableArray<Record *>*)readAllNames
{
    
    NSMutableArray *records = [NSMutableArray array];
    
    FMResultSet *set = [_database executeQuery:@"select distinct name from records"];
    while ([set next])
    {
        Record *record =[[Record alloc] init];
        //record.serialId = [set longLongIntForColumn:@"id"];
        record.name = [set stringForColumn:@"name"];
        //record.subject = [set stringForColumn:@"subject"];
        //record.score = [set stringForColumn:@"score"];
        [records addObject:record];
    }
    [set close];
    
    return records;
}


- (NSMutableArray<Record *>*)readScoresOfName:(NSString *)name
{
    
    NSMutableArray *records = [NSMutableArray array];
    
    FMResultSet *set = [_database executeQuery:@"select * from records where name = ?",name];
    while ([set next])
    {
        Record *record =[[Record alloc] init];
        record.serialId = [set longLongIntForColumn:@"id"];
        record.name = [set stringForColumn:@"name"];
        record.subject = [set stringForColumn:@"subject"];
        record.score = [set stringForColumn:@"score"];
        [records addObject:record];
    }
    [set close];
    
    return records;
}

- (NSMutableArray<Record *>*)readScoresOfSubject:(NSString *)subject
{
    
    NSMutableArray *records = [NSMutableArray array];
    
    FMResultSet *set = [_database executeQuery:@"select * from records where subject = ?",subject];
    while ([set next])
    {
        Record *record =[[Record alloc] init];
        record.serialId = [set longLongIntForColumn:@"id"];
        record.name = [set stringForColumn:@"name"];
        record.subject = [set stringForColumn:@"name"];
        record.score = [set stringForColumn:@"score"];
        [records addObject:record];
    }
    [set close];
    
    return records;
}


- (NSMutableArray<Record *>*)readAllSubjects
{
    
    NSMutableArray *records = [NSMutableArray array];
    
    FMResultSet *set = [_database executeQuery:@"select distinct subject from records"];
    while ([set next])
    {
        Record *record =[[Record alloc] init];
        //record.serialId = [set longLongIntForColumn:@"id"];
        //record.name = [set stringForColumn:@"name"];
        record.subject = [set stringForColumn:@"subject"];
        //record.score = [set stringForColumn:@"score"];
        [records addObject:record];
    }
    [set close];
    
    return records;
}


- (NSString *)filepath
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return  [documents stringByAppendingPathComponent:@"records.db"];
}

- (void)openDatabase
{
    
    NSString *filepath = [self filepath];
    _database = [FMDatabase databaseWithPath:filepath];
    if ([_database open])
    {
        if ([_database executeUpdate:@"create table if not exists records(id integer primary key autoincrement,name text,subject text,score text)"])
        {
        
            if( [self readAllNames].count == 0){
                
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Damon','语文','71')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Damon','数学','81')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Damon','英语','91')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Damon','体育','61')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Woody','语文','82')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Woody','数学','72')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Woody','英语','62')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Woody','体育','52')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Apple','语文','72')"];
                [_database executeUpdate:@"INSERT INTO `records` (name,subject,score) VALUES ('Apple','地理','72')"];
                
            }
            

            
        }else{
            
            NSLog(@"open database failed");
            
        }

        
    }
    else
    {
        NSLog(@"open database failed");
    }
}


@end
