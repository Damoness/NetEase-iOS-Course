//
//  DatabaseManager.h
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"
@interface DatabaseManager : NSObject


+(instancetype)sharedManager;


- (NSMutableArray<Record *>*)readAllNamesByStr:(NSString *)str;

- (NSMutableArray<Record *>*)readAllSubjects;
- (NSMutableArray<Record *>*)readAllNames;
- (NSMutableArray<Record *>*)readScoresOfSubject:(NSString *)subject;
- (NSMutableArray<Record *>*)readScoresOfName:(NSString *)name;

-(BOOL)addRecord:(Record *)record;
@end
