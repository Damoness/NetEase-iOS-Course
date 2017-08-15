//
//  MyBlogViewController.m
//  MyBlog
//
//  Created by CyouGuang on 17/5/29.
//  Copyright © 2017年 CyouGuang. All rights reserved.
//

#import "MyBlogViewController.h"
#import "ArticleView.h"
@interface MyBlogViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *inputBgImageView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIView *acticleViewController;
@end

@implementation MyBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *imputBgImage = [_inputBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22)resizingMode:UIImageResizingModeStretch];
    [_inputBgImageView setImage:imputBgImage];
    //设置背景
    
    UIImage *buttonBgImage = [[UIImage imageNamed:@"button-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_sendButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];//按钮正常时
    [_sendButton setBackgroundImage:buttonBgImage forState:UIControlStateHighlighted];//按钮被点击时
    [_sendButton setBackgroundImage:buttonBgImage forState:UIControlStateDisabled];
    //设置按钮背景图片
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendButtonAction:(id)sender {
    if([_inputTextField.text length] == 0)return;//若发布内容为空则直接返回
    
    ArticleView *view = [[[UINib nibWithNibName:@"ArticleView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    
    [view.nameLabel setText:@"我"];
    
    NSData *currentDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc]init];
    [dateFomatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];//设置时间格式
    NSString *timeString = [dateFomatter stringFromDate:currentDate];//转为字符串形式
    [view.dateLabel setText:timeString];
    //获取本地时间
    [view.contentLabel setText:_inputTextField.text];
    //加入post内容
    [_acticleViewController addSubview:view];
    //将AritlcView加入视图中
    [self updateLastArticleViewConstraints];
    [view setTransform:CGAffineTransformMakeScale(0, 0)];//动画
    [UIView animateWithDuration:0.7f animations:^{
        [view setTransform:CGAffineTransformIdentity];
    }];

}
-(void)updateLastArticleViewConstraints{
    ArticleView *view = [_acticleViewController.subviews lastObject];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_acticleViewController setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    if (_acticleViewController.subviews.count == 1) {
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_acticleViewController attribute:NSLayoutAttributeTop multiplier:1 constant:2];
        [_acticleViewController addConstraint:topConstraint];
    }else{
        //NSArray *viewArray = _articleContentView.subviews;
        UIView *preView = [_acticleViewController.subviews objectAtIndex:_acticleViewController.subviews.count - 2];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:preView attribute:NSLayoutAttributeBottom multiplier:1 constant:12];
        [_acticleViewController addConstraint:topConstraint];
    }
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_acticleViewController attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_acticleViewController attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    [_acticleViewController addConstraint:leftConstraint];
    [_acticleViewController addConstraint:rightConstraint];
}

-(void)upDateLastArticleViewFrame{
    ArticleView *view = [_acticleViewController.subviews lastObject];
    CGFloat offsetY = 0;
    if (_acticleViewController.subviews.count == 1) {
        offsetY = 12.f;
    }else{
        NSArray *viewArray = _acticleViewController.subviews;
        UIView *preView = viewArray[viewArray.count-2];
        //offsetY = preView.frame.origin.y+preView.frame.size+12;
        offsetY = CGRectGetMaxY(preView.frame) + 12;
    }
    CGFloat contentLabelHeight = [view.contentLabel sizeThatFits:CGSizeMake(CGRectGetWidth(_acticleViewController.bounds)-46, CGFLOAT_MAX)].height;
    CGRect frame = CGRectMake(0, offsetY,CGRectGetWidth(_acticleViewController.frame), 39+contentLabelHeight);
    [view setFrame:frame];
}

-(void)upDateLastArticleViewFrame2{
    ArticleView *view = [_acticleViewController.subviews lastObject];
    CGFloat offsetY = 0;
    if (_acticleViewController.subviews.count == 1) {
        offsetY = 12.f;
    }else{
        NSArray *viewArray = _acticleViewController.subviews;
        UIView *preView = viewArray[viewArray.count-2];
        //offsetY = preView.frame.origin.y+preView.frame.size+12;
        offsetY = CGRectGetMaxY(preView.frame) + 12;
    }
    //CGFloat contentLabelHeight = [view.contentLabel sizeThatFits:CGSizeMake(CGRectGetWidth(_articleContentView.bounds)-46, CGFLOAT_MAX)].height;
    CGFloat contentLabelHeight = [view.contentLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_acticleViewController.bounds)-46.f,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:view.contentLabel.font} context:nil].size.height;
    CGRect frame = CGRectMake(0, offsetY,CGRectGetWidth(_acticleViewController.frame), 39+contentLabelHeight);
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
