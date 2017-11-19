//
//  FilpViewController.m
//  UIViewAnimationDemo_Me
//
//  Created by Damoness on 2017/11/18.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "FilpViewController.h"

@interface FilpViewController (){
    
    UIView *_rootView;
    UIView *_square1;
    UIView *_square2;
}

@end

@implementation FilpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"Flip animation";
    
    
    _rootView = ({
       
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.whiteColor;
        view.bounds = CGRectMake(0, 0, 50, 50);
        
        view.center = self.view.center;
        
        [self.view addSubview:view];
        
        view;
        
    });
    
    
    _square1 = [[UIView alloc] init];
    _square1.backgroundColor = [UIColor orangeColor];
    _square1.frame = _rootView.bounds;
    [_rootView addSubview:_square1];
    
    _square2 = [[UIView alloc] init];
    _square2.backgroundColor = [UIColor yellowColor];
    _square2.frame = _square1.frame;
    _square2.hidden = YES;
    [_rootView addSubview:_square2];
    
    
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //[self startFliping];
    
    [self startBlockFliping];
}

- (void)startBlockFliping{
    
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionCurlUp;
    
    
    [UIView transitionWithView:_rootView duration:1 options:options animations:^{
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)startFliping{
    
    [UIView beginAnimations:@"Flip Animation" context:(__bridge void *)(self)];
    [UIView setAnimationDuration:2];
    
    //翻转某个视图
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_rootView cache:YES];
    
    _square1.hidden = !_square1.hidden;
    _square2.hidden = !_square2.hidden;
    
    [UIView commitAnimations];

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
