//
//  WDMaskLayerViewController.m
//  LayerUse_Me
//
//  Created by 吴狄 on 2017/7/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "WDMaskLayerViewController.h"

@interface WDMaskLayerViewController ()

@end

@implementation WDMaskLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chatImage.JPG"]];
    
    imageView.frame = CGRectMake(0, 0, 200, 250);
    imageView.center = self.view.center;
    
    UIImageView *maskImageView = [[UIImageView alloc]init];
    maskImageView.frame  = imageView.bounds;
    
    maskImageView.image = [[UIImage imageNamed:@"imageMask"]resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeStretch];

    imageView.layer.mask = maskImageView.layer;
    
    [self.view addSubview:imageView];
    
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
