//
//  ViewController.m
//  1.UIView布局流程
//
//  Created by 吴狄 on 2017/6/3.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"


#import "ColorView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *grayView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greyViewHeightConstraint;


@property (nonatomic) Boolean hasAddColorView;
@end

@implementation ViewController



-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self  = [super initWithCoder:aDecoder];
    
    if (self) {
        
        NSLog(@"%s",__func__);
    }

    return self;
}

-(void)loadView{
    [super loadView];
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%s",__func__);
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    
    
    [self.grayView addGestureRecognizer:gestureRecognizer];
    
}

-(void)tapAction{
    
    
//    ViewController2 *vc2 = [ViewController2 new];
    
//    
//    ViewController2 *vc2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController2 class])];
//    
//    
//    //[self.navigationController pushViewController:vc2 animated:YES];
//    
//    
//    [self presentViewController:vc2 animated:YES completion:nil];
    
    
    
    if (self.hasAddColorView) {
        
        
        [UIView animateWithDuration:1.0 animations:^{
           
            if (self.greyViewHeightConstraint.constant == 100.0f) {
                
                self.greyViewHeightConstraint.constant = 150;
                
            }else{
                
                self.greyViewHeightConstraint.constant = 100;
            }
            
                   // [self.grayView setNeedsUpdateConstraints];
                   // [self.grayView updateConstraintsIfNeeded];
            
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];

        }];
        
        
//        [UIView animateWithDuration:1.0 animations:^{
//           
//            CGRect frame = self.grayView.frame;
//            
//            if (frame.size.height == 100) {
//                frame.size.height = 150;
//            }else{
//                
//                frame.size.height = 100;
//            }
//            
//            self.grayView.frame  = frame;
//            
//        }];
//        


        
    }else{
        
        
        //    ColorView *colorView = [[[UINib nibWithNibName:@"ColorView" bundle:nil]instantiateWithOwner:nil options:nil]lastObject];
        
        
        ColorView *colorView = [[[NSBundle mainBundle]loadNibNamed:@"ColorView" owner:nil options:nil]lastObject];
        
        //colorView.frame = CGRectMake(20, 280, 200, 50);
        
        
        [colorView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        
        NSLayoutConstraint *top =  [NSLayoutConstraint constraintWithItem:colorView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.grayView attribute:NSLayoutAttributeBottom multiplier:1 constant:150];
        
        NSLayoutConstraint *left =  [NSLayoutConstraint constraintWithItem:colorView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:50];
        
        NSLayoutConstraint *right =  [NSLayoutConstraint constraintWithItem:colorView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-50];
        
        NSLayoutConstraint *bottom =  [NSLayoutConstraint constraintWithItem:colorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50];
        
        
        //NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:colorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
        
        
        [self.view addSubview:colorView];
        
        
        
        [self.view addConstraints:@[top,left,right,bottom]];
        
        
        self.hasAddColorView = YES;
        
    }
    

    
    
    

    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
    
    
}// Called when the view is about to made visible. Default does nothing
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
    
    
}// Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    NSLog(@"%s",__func__);
    
}// Called after the view was dismissed, covered or otherwise hidden. Default does nothing
//
// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewWillLayoutSubviews NS_AVAILABLE_IOS(5_0){
    
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__func__);
    
}




// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews NS_AVAILABLE_IOS(5_0)
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"%s",__func__);
    
}



-(void)updateViewConstraints{
    
    [super updateViewConstraints];
    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
