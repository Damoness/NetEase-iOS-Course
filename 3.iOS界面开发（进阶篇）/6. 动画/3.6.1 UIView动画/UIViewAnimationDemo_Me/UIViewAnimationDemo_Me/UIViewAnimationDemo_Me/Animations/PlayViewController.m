//
//  PlayViewController.m
//  UIViewAnimationDemo_Me
//
//  Created by Damoness on 2017/11/18.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController (){
    
    UIView *_squareView;
    UIImageView *_coverImageView;
    UIImageView *_diskImageView;
    UIImageView *_needleImageView;
    
    BOOL _animating;
}

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Play animation";
    
    
    _squareView = [UIView new];
    _squareView.bounds = CGRectMake(0, 0, 50, 50);
    _squareView.backgroundColor = UIColor.redColor;
    _squareView.center = self.view.center;
    [self.view addSubview:_squareView];
    

    [self setUpView];
}


- (void)setUpView{
    
    _coverImageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Cover.jpg"]];
    _diskImageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Disk"]];
    _needleImageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Needle.png"]];
    
    _diskImageView.bounds = CGRectMake(0, 0, 300, 300);

    _coverImageView.bounds = CGRectMake(0, 0, 200, 200);
    _diskImageView.center = self.view.center;
    _coverImageView.center = _diskImageView.center;
    
    [self.view addSubview:_coverImageView];
    [self.view addSubview:_diskImageView];

    
    _needleImageView.center  = CGPointMake(CGRectGetMidX(self.view.frame), 64);
    _needleImageView.transform = CGAffineTransformMakeRotation(-M_PI_4 / 2);
    [self.view addSubview:_needleImageView];
    
    _animating = NO;
}


- (void)startPlaying{
    
    _animating = YES;
    
    [UIView animateWithDuration:1 animations:^{
        
        _needleImageView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        
        UIViewKeyframeAnimationOptions options = UIViewKeyframeAnimationOptionRepeat | UIViewAnimationOptionCurveLinear;
        
        NSUInteger  playAnimationDuration = 4;
        
        [UIView animateKeyframesWithDuration:playAnimationDuration delay:0 options:options animations:^{
            
            
            
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
                
                _coverImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
                _diskImageView.transform = _coverImageView.transform;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
                
                _coverImageView.transform = CGAffineTransformMakeRotation(M_PI_2 * 2);
                _diskImageView.transform = _coverImageView.transform;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
                
                _coverImageView.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
                _diskImageView.transform = _coverImageView.transform;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
                
                _coverImageView.transform = CGAffineTransformMakeRotation(M_PI_2 * 4);
                _diskImageView.transform = _coverImageView.transform;
            }];
            
            
        } completion:^(BOOL finished) {
            
            
            
        }];

    }];
    
}

-(void)stop{
    
    
    
    [UIView animateWithDuration:1 animations:^{
       
        _needleImageView.transform = CGAffineTransformMakeRotation(-M_PI_4 / 2);;
        
        _diskImageView.transform = CGAffineTransformIdentity;
        _coverImageView.transform = _diskImageView.transform;
        
    } completion:^(BOOL finished) {
        
        _animating = NO;
        
    }];
    
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
    if (_animating) {
        
        
        [self stop];
        
    }else{
        
        [self startPlaying];
        
        
    }
    

    
    
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
