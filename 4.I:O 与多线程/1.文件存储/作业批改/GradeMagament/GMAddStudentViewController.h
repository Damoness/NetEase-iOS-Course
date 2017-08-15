//
//  GMAddStudentViewController.h
//  GradeMagament
//
//  Created by ShaoweiZhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMRecord.h"

@protocol AddStudentDelegate <NSObject>

- (void)onAddStudentRecord:(GMRecord *)record;

@end

@interface GMAddStudentViewController : UIViewController

@property (nonatomic, weak) id<AddStudentDelegate> delegate;

@end
