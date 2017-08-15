//
//  AddRecordViewController.h
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"
@protocol AddRecordDelegate <NSObject>

-(void)addRecord:(Record *)record;

@end


@interface AddRecordViewController : UIViewController
@property (weak)id<AddRecordDelegate>delegate;
@end
