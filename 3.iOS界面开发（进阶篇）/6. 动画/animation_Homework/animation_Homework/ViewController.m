//
//  ViewController.m
//  animation_Homework
//
//  Created by 吴狄 on 2017/7/3.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewController.h"
#import "OCAndSwift-Swift.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet ESTMusicIndicatorView *animationView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (IBAction)startAnimationPressed:(UIButton *)sender {
    
    
    [self.animationView startAnimating];
    
    
}

- (IBAction)stopAnimationPressed:(UIButton *)sender {
    
    
    [self.animationView stopAnimating];
}


@end
