//
//  GMAddStudentViewController.m
//  GradeMagament
//
//  Created by ShaoweiZhang on 8/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "GMAddStudentViewController.h"

@interface GMAddStudentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *gradeTextField;

@end

@implementation GMAddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonClicked:(id)sender {
    NSString *name = _nameTextField.text;
    NSString *subject = _subjectTextField.text;
    NSString *grade = _gradeTextField.text;
    BOOL isInputValid = NO;
    
    if (name.length>0 && subject.length>0 && grade.length>0) {
        if ([GMRecord isValidGrade: [grade floatValue]]) {
            GMRecord *record = [[GMRecord alloc] initWithName:name Subject:subject Grade:[grade floatValue]];
            [self.delegate onAddStudentRecord:record];
            isInputValid = YES;
        }
    }
    
    if (isInputValid) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"输入不合法" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
