//
//  GMRecord.h
//  GradeMagament
//
//  Created by Shaowei Zhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GMRecord : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, assign) float grade;

+ (BOOL)isValidGrade:(float)grade;
- (instancetype)initWithName:(NSString*)name Subject:(NSString*)subject Grade:(float)grade;
- (BOOL)hasPassed;

@end
