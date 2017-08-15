//
//  Record.h
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject

@property (nonatomic,assign)    int64_t     serialId;

@property (nonatomic) NSString *name;

@property (nonatomic) NSString *subject;

@property (nonatomic) NSString *score;

@end
