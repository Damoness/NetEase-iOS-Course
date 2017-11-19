//
//  ViewAnimationViewController.m
//  UIViewAnimationDemo_Me
//
//  Created by Damoness on 2017/11/18.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewAnimationViewController.h"

@interface ViewAnimationViewController (){
    
    UIView *_square;
}

@end

@implementation ViewAnimationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"View animation";
    
    
    _square = [UIView new];
    _square.backgroundColor = UIColor.redColor;
    _square.bounds = CGRectMake(0, 0, 50, 50);
    _square.center = self.view.center;
    
    [self.view addSubview:_square];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    _square.center = self.view.center;
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self startBlockAnimation];
    
}


- (void)startAnimating{
    
                                                  //__bridge 不移交控制权
    [UIView beginAnimations:@"animation" context:(__bridge void *)(self)]; //开始
    
    [UIView setAnimationDuration:0.4]; //设置时间
    _square.center = CGPointMake(_square.center.x + 100, _square.center.y);
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    
}


- (void)startBlockAnimation{

    UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse | UIViewAnimationOptionTransitionCrossDissolve ;
    
    [UIView animateWithDuration:0.4 delay:0 options:options animations:^{
        
        _square.center = CGPointMake(_square.center.x + 100, _square.center.y);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    
    _square.center = self.view.center;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
