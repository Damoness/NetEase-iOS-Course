//
//  ViewController.m
//  NSTreadDemo_Me
//
//  Created by 吴狄 on 2017/7/10.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadImageButtonPressed:(UIButton *)sender {
    
    
    NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/09/23/21/23/iphone-6-458159_960_720.jpg"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    self.imageView.image = [UIImage imageWithData:data];

    
    //self pe
    
    
}

@end
