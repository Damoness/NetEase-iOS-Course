//
//  MyCameraViewController.m
//  AVCaptureSessionDemo
//
//  Created by Chengyin on 16/9/22.
//  Copyright © 2016年 Chengyin. All rights reserved.
//

#import "MyCameraViewController.h"
@import AVFoundation;

@interface MyCameraViewController ()
{
@private
}
@end

@implementation MyCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Take" style:UIBarButtonItemStylePlain target:self action:@selector(takeAction:)];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    
    UIButton *switchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    switchButton.frame = CGRectMake(0, 0, titleView.bounds.size.width / 2, titleView.bounds.size.height);
    switchButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [switchButton setTitle:@"Switch" forState:UIControlStateNormal];
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:switchButton];
    
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    flashButton.frame = CGRectMake(titleView.bounds.size.width / 2, 0, titleView.bounds.size.width / 2, titleView.bounds.size.height);
    flashButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [flashButton setTitle:@"Flash" forState:UIControlStateNormal];
    [flashButton addTarget:self action:@selector(flashAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:flashButton];
    
    self.navigationItem.titleView = titleView;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.title = @"Camera";
    
    
    [self requestAuthorization:^(BOOL granted) {
       
        [self performSelectorOnMainThread:@selector(requestAuthorization:) withObject:@(granted) waitUntilDone:NO];
        
    }];
}



#pragma mark -- permission
-(void)requestAuthorization:(void(^)(BOOL granted))handler{
    
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    
    if (status == AVAuthorizationStatusNotDetermined) {
        
     
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:handler];
        
    }else if(handler){
        
        handler(status == AVAuthorizationStatusAuthorized);
    }
    
    
}

-(void)requestAuthorizationFinished:(NSNumber *)granted{
    
    if ([granted boolValue]) {
        
        
    }else{
        
        
        NSLog(@"失败");
        
    }
    
}


#pragma mark camera
-(void)createCemara{

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)cancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)takeAction:(id)sender
{

}

- (void)switchAction:(id)sender
{
    
}


- (void)flashAction:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
