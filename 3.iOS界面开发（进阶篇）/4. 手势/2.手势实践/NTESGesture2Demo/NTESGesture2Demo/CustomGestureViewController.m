//
//  CustomGestureViewController.m
//  Gesture2Demo
//
//  Created by jeunfung on 16/9/28.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "CustomGestureViewController.h"
#import "CustomGestureRecognizer.h"

@implementation CustomGestureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CustomGestureRecognizer *gesture = [[CustomGestureRecognizer alloc] initWithTarget:self action:@selector(customGesture:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)customGesture:(CustomGestureRecognizer *)gesture
{
    [self alertMessage:@"custom gesture!!"];
}

- (void)alertMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
