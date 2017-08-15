//
//  MyBlogViewController.m
//  MyBlog
//
//  Created by 姚凯 on 2017/5/20.
//  Copyright © 2017年 姚凯. All rights reserved.
//

#import "MyBlogViewController.h"
#import "ArticleView.h"

@interface MyBlogViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TextField;
@property (weak, nonatomic) IBOutlet UIButton *BlogButton;
@property (weak, nonatomic) IBOutlet UIView *articleContenView;

@end

@implementation MyBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage * buttonImage = [[UIImage imageNamed:@"button-green"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)resizingMode:UIImageResizingModeStretch];
    [_BlogButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [_BlogButton setBackgroundImage:buttonImage forState:UIControlStateHighlighted];
    
    UIImage * TextFieldImage = [[UIImage imageNamed:@"bg-input"]resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_TextField setBackground:TextFieldImage];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)postButtonAction:(id)sender
{
    
    if(_TextField.text.length == 0){
        return;
    }
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timestring = [dateformat stringFromDate:currentDate];
    
    
    //获取的是一个数组
    ArticleView *view = [[[UINib nibWithNibName:@"ArticleView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    [view.NameLabel setText:@"我"];
    [view.TimeLabel setText:timestring];
    [view.Label setText:_TextField.text];
    [_articleContenView addSubview:view];
    [self updateLastArticleViewFrame];
    NSLog(@"添加日志成功！");
    
}

- (void)updateLastArticleViewFrame
{

    ArticleView *view = [_articleContenView.subviews lastObject];
    CGFloat offsetY = 0;
    if(_articleContenView.subviews.count ==1){
        offsetY = 12.f;
    
    }else{
    
        NSArray *viewArray = _articleContenView.subviews;
        UIView *preView = viewArray[viewArray.count -2];
   //     offsetY = preView.frame.origin.y+preView.frame.size.height+12;
        offsetY = CGRectGetMaxY(preView.frame)+12;
    
    }
    
    
    CGFloat contentLabelHeight = [view.Label sizeThatFits:CGSizeMake(CGRectGetWidth(_articleContenView.bounds)-46.f, CGFLOAT_MAX)].height ;
    CGRect frame = CGRectMake(0, 12, CGRectGetWidth(_articleContenView.bounds), 39+contentLabelHeight);
    
    [view setFrame:frame];


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
