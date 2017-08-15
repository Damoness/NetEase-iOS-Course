//
//  AddStudentViewController.m
//  学生成绩录入系统
//
//  Created by zhen7216 on 2017/7/7.
//  Copyright © 2017年 chenzhen. All rights reserved.
//

#import "AddStudentViewController.h"

@interface AddStudentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextfield;
@property (weak, nonatomic) IBOutlet UITextField *achivementTextfield;

@end

@implementation AddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancel:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(onCancel)])
    {
        [_delegate onCancel];
    }
}

- (IBAction)onSave:(id)sender {
    NSString *name = _nameTextfield.text;
    NSString *subject = _subjectTextfield.text;
    NSString *achivement = _achivementTextfield.text;
    if ([name length] && [subject length])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(onAddStudent:subject:achivement:)])
        {
            [_delegate onAddStudent:name subject:subject achivement:achivement];
        }
    }
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
