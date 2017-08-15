//
//  LogModel.h
//  NetEaseTest_SimpleLog
//
//  Created by _Sharuru on 2017/6/3.
//  Copyright © 2017年 KarinoSharuru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LogModel : NSObject

/// content
@property(nonatomic, copy, readonly) NSString *content;
/// time
@property(nonatomic, copy, readonly) NSString *time;
/// height
@property(nonatomic, assign) CGFloat height;

- (instancetype)initWithContent:(NSString *)content;

@end
