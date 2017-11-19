//
//  KeyFrameViewController.m
//  UIViewAnimationDemo_Me
//
//  Created by Damoness on 2017/11/18.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController (){
    
    UIView *_square;
}

@end

@implementation KeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"keyFrame animation";
    
    _square = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _square.center = self.view.center;
    _square.backgroundColor = UIColor.redColor;
    [self.view addSubview:_square];
    

}



- (void) startAnimating {
    
    
    //四个动画组成一个动画,不流畅
    
    [UIView animateWithDuration:1 animations:^{
        
        _square.center = CGPointMake(_square.center.x + 100, _square.center.y);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            _square.center = CGPointMake(_square.center.x , _square.center.y + 100);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                
                _square.center = CGPointMake(_square.center.x - 100, _square.center.y);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
                    
                    _square.center = CGPointMake(_square.center.x , _square.center.y - 100);
                } completion:^(BOOL finished) {
            
                    
                }];
                
                
            }];
            
            
        }];
        
        
    }];
    
}


- (void)startKeyFrameAnimation{
    
    UIViewKeyframeAnimationOptions options = UIViewKeyframeAnimationOptionRepeat;
    
    [UIView animateKeyframesWithDuration:4 delay:0 options:options animations:^{
        
        
        double frameDuration = 1.0 / 4;
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:frameDuration animations:^{
            
            _square.center = CGPointMake(_square.center.x + 100, _square.center.y);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:frameDuration  relativeDuration:frameDuration animations:^{
            
            _square.center = CGPointMake(_square.center.x , _square.center.y + 100);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:frameDuration * 2 relativeDuration:frameDuration animations:^{
            
            _square.center = CGPointMake(_square.center.x - 100, _square.center.y);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:frameDuration * 3 relativeDuration:frameDuration animations:^{
            
            _square.center = CGPointMake(_square.center.x , _square.center.y -100);
            
        }];
        
        
        
    } completion:nil];
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self startKeyFrameAnimation];
    
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
