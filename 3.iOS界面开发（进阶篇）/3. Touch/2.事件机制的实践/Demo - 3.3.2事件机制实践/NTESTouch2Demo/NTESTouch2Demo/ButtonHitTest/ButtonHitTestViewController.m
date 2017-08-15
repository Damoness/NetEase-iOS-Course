//
//  ButtonHitTestViewController.m
//  Touch2Demo
//
//  Created by jeunfung on 16/8/4.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ButtonHitTestViewController.h"
#import "ButtonHitTestView.h"

@implementation ButtonHitTestViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.navigationItem.title = @"Button HitTest";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ButtonHitTestView *view = [[ButtonHitTestView alloc] init];
    [self.view addSubview:view];
    view.frame = CGRectMake(50, 50, 200, 200);
}

@end
