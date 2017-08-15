//
//  FirstViewController.m
//  navigationController
//
//  Created by lusuihao-mac on 2017/5/26.
//  Copyright © 2017年 lusuihao-mac. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UITextFieldDelegate>
@property (nonatomic,weak)UITextField * textfield;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"扫一扫icon"] style:UIBarButtonItemStylePlain target:self action:@selector(showAlbum)];
    leftItem.tintColor = [UIColor blackColor];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"消息中心入口"] style:UIBarButtonItemStylePlain target:self action:@selector(showMessage)];
    rightItem.tintColor = [UIColor blackColor];
    [self.navigationItem setRightBarButtonItem:rightItem];
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 60 * 2 , 40)];
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, titleView.bounds.size.width, titleView.bounds.size.height)];
    [textfield setBorderStyle:UITextBorderStyleRoundedRect];
    [textfield setBackgroundColor:[UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1.0f]];
    [textfield setPlaceholder:@"在千万海外商品中搜索"];
    [textfield setValue:[UIColor colorWithRed:84/255.f green:84/255.f blue:84/255.f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    //UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [searchImage setImage:[UIImage imageNamed:@"searchIcon"]];
    //[searchView addSubview:searchImage];
    textfield.leftView = searchImage;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    [titleView addSubview:textfield];
    
   // [titleView setBackgroundColor:[UIColor blackColor]];
    self.navigationItem.titleView = titleView;
    // Do any additional setup after loading the view.
    textfield.delegate = self;
    _textfield = textfield;
}

-(void)showAlbum{
    UIImagePickerController * Album = [[UIImagePickerController alloc]init];
    Album.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    Album.allowsEditing = NO;
    [self presentViewController:Album animated:YES completion:nil];
    NSLog(@"show Album");
}
-(void)showMessage{
    UIViewController * message = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"messagePage"];
    [self presentViewController:message animated:YES completion:nil];
    NSLog(@"show Message");


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.textfield.isExclusiveTouch) {
        [self.textfield resignFirstResponder];
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
