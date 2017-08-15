//
//  ButtonSubViewOutsideViewController.m
//  Touch2Demo
//
//  Created by jeunfung on 16/8/4.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ButtonSubViewOutsideViewController.h"
#import "ButtonSubViewOutsideView.h"

@implementation ButtonSubViewOutsideViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Subview OutSide";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ButtonSubViewOutsideView *view = [[ButtonSubViewOutsideView alloc] init];
    [self.view addSubview:view];
    view.frame = CGRectMake(50, 50, 200, 200);
}



@end
