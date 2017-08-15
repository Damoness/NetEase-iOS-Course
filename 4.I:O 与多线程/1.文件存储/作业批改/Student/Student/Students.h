//
//  Students.h
//  Student
//
//  Created by jele lam on 19/7/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Students : NSObject
@property (nonatomic, assign) int64_t serialId;
@property (nonatomic, strong) NSString *studentName;
@property (nonatomic, strong) NSString *subjectName;
@property (nonatomic, strong) NSNumber *score;
@end


