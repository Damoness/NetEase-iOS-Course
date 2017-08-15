//
//  GestureSimultaneousViewController.m
//  Gesture2Demo
//
//  Created by jeunfung on 16/9/28.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "GestureSimultaneousViewController.h"

@interface GestureSimultaneousViewController()<UIGestureRecognizerDelegate>
{
    UIView *_view;
    
    UIPinchGestureRecognizer *_pinch;
    UIRotationGestureRecognizer *_rotation;
}

@end

@implementation GestureSimultaneousViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _view = [[UIView alloc] init];
    _view.backgroundColor = [UIColor orangeColor];
    _view.frame = CGRectMake(50, 50, 150, 150);
    [self.view addSubview:_view];
    
    _rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    _rotation.delegate = self;
    [self.view addGestureRecognizer:_rotation];
    
    _pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    _pinch.delegate = self;
    [self.view addGestureRecognizer:_pinch];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


- (void)rotate:(UIRotationGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        _view.transform = CGAffineTransformRotate(_view.transform, gesture.rotation);
        [gesture setRotation:0];
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        _view.transform = CGAffineTransformScale(_view.transform, gesture.scale, gesture.scale);
        gesture.scale = 1;
    }
}

@end
