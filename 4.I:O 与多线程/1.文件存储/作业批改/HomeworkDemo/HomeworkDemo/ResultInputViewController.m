//
//  ResultInputViewController.m
//  HomeworkDemo
//
//  Created by Hmyy on 2017/7/23.
//  Copyright © 2017年 Hmyy. All rights reserved.
//

#import "ResultInputViewController.h"

@interface ResultInputViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *courseTextfield;
@property (weak, nonatomic) IBOutlet UITextField *scoreTextfield;

@end

@implementation ResultInputViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"录入成绩";
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

- (IBAction)onCancel:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(onCancel)])
    {
        [_delegate onCancel];
    }
}

- (IBAction)onInput:(id)sender
{
    NSString *name = _nameTextfield.text;
    NSString *course = _courseTextfield.text;
    NSString *score = _scoreTextfield.text;
    
    if ([name length] && [course length])
    {
        StudentResult *result = [[StudentResult alloc] init];
        result.name = name;
        result.course = course;
        result.score = score;

        if (_delegate && [_delegate respondsToSelector:@selector(onInputResult:)])
        {
            [_delegate onInputResult:result];
        }
    }
}

@end
