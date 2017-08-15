//
//  AddRecordViewController.m
//  HomeWork_File
//
//  Created by wd on 2017/7/23.
//  Copyright © 2017年 ditiy. All rights reserved.
//

#import "AddRecordViewController.h"

@interface AddRecordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"增加记录";
}


- (IBAction)save:(UIButton *)sender {
    
    if (self.nameTextField.text && self.subjectTextField && self.scoreTextField.text && [self.scoreTextField.text intValue] >=0 && [self.scoreTextField.text intValue] <=100) {
        
        
        if ([self.delegate respondsToSelector:@selector(addRecord:)]) {
            
            Record *record = [Record new];
            record.name = self.nameTextField.text;
            record.subject = self.subjectTextField.text;
            record.score = self.scoreTextField.text;
            
            
            [self.delegate addRecord:record];
        }
        
        
    }else{
        
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"错误" message:@"请正确填写信息" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertControler animated:YES completion:nil];
        
        
        
        
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
