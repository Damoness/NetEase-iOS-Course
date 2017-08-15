//
//  ResultInputViewController.h
//  HomeworkDemo
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentResult.h"

@protocol ResultInputDelegate <NSObject>
- (void)onInputResult:(StudentResult *)result;
- (void)onCancel;
@end

@interface ResultInputViewController : UIViewController

@property (nonatomic,weak)  id<ResultInputDelegate>  delegate;

@end
