//
//  AddStudentsViewController.m
//  StudentsDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "AddStudentsViewController.h"
#define NUMBERS @"0123456789.\n"
@interface AddStudentsViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextfield;
@property (weak, nonatomic) IBOutlet UITextField *scoreTextfiled;

@end

@implementation AddStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加联系人";
    _scoreTextfiled.delegate = self;
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
    NSNumber *score = [NSNumber numberWithFloat:_scoreTextfiled.text.floatValue];
    
    if ([name length] && [subject length] && [self textFieldShouldEndEditing:_scoreTextfiled])
    {
        Students *student = [[Students alloc] init];
        student.studentName = name;
        student.subjectName = subject;
        student.score = score;
        if (_delegate && [_delegate respondsToSelector:@selector(onAddStudents:)])
        {
            [_delegate onAddStudents:student];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if(textField == _scoreTextfiled)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入数字"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return NO;
        }
        NSLog(@"%f",filtered.floatValue);

    }
    //其他的类型不需要检测，直接写入
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"%s",__FUNCTION__);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%s",__FUNCTION__);
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.text.floatValue > 100.0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入 0-100 以内的分数"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
    }
    return YES;
}

@end
