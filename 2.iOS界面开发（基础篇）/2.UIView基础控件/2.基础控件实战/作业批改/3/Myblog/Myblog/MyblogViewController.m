//
//  MyblogViewController.m
//  Myblog
//
//  Created by 江宝敏 on 2017/5/25.
//  Copyright © 2017年 江宝敏. All rights reserved.
//

#import "MyblogViewController.h"
#import "ArticleView.h"


@interface MyblogViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *textBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UIView *articleContentView;

@end

@implementation MyblogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *inputimage = [_textBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_textBgImageView setImage:inputimage];
    [_textBgImageView setImage:inputimage];
    
    UIImage *buttonBgImage=[_postButton.currentBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:UIImageResizingModeStretch];
    [_postButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    [_postButton setBackgroundImage:buttonBgImage forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postButtonAction:(id)sender
{
    [self.view endEditing:YES];
    
    if (_textFiled.text.length==0){
        return;
    }
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *dateformatter =[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeString=[dateformatter  stringFromDate:currentdate];
    
    ArticleView *view =[[[UINib nibWithNibName:@"ArticleView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    [view.nameLabel setText:@"我"];
    [view.dateLabel setText:timeString];
    [view.contentLabel setText:_textFiled.text];
    [_articleContentView addSubview:view];
    
    [self updateLastArticleViewConstraint];
    
    [view setTransform:CGAffineTransformMakeScale(0, 0)];
    
    [UIView animateWithDuration:2.f animations:^{
        [view setTransform:CGAffineTransformIdentity];
    }];
    
}

- (void) updateLastArticleViewConstraint
{
    ArticleView *view =[_articleContentView.subviews lastObject];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_articleContentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    if (_articleContentView.subviews.count ==2){
        NSLayoutConstraint *topConstraint=[NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:_articleContentView
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                      constant:12];
        [_articleContentView addConstraint:topConstraint];
        
    }else{
        ArticleView *preArticleView= [_articleContentView.subviews objectAtIndex:(_articleContentView.subviews.count-2)];
        NSLayoutConstraint *topConstraint =[NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:preArticleView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:12];
        [_articleContentView addConstraint:topConstraint];
    }
    
    NSLayoutConstraint *leftConstraint =[NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_articleContentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:0];
    NSLayoutConstraint *rightConstraint =[NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeRight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:_articleContentView
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1
                                                                       constant:0];
    [_articleContentView addConstraint:leftConstraint];
    [_articleContentView addConstraint:rightConstraint];
    
}

//- (void)updateLastArticleViewFrame
//{
//    ArticleView *view =[_articleContentView.subviews lastObject];
//    CGFloat offsetY=0.f;
//    if(_articleContentView.subviews.count==1){
//        offsetY=12.f;
//    }else{
//        NSArray *viewarray =_articleContentView.subviews;
//        UIView *preview=viewarray[viewarray.count-2];
//        offsetY=CGRectGetMaxY(preview.frame)+12;
//    }
//    
//    CGFloat contentLabelHeight = [view.contentLabel sizeThatFits:CGSizeMake(CGRectGetWidth(_articleContentView.bounds)-46.f, CGFLOAT_MAX)].height;
//    CGRect frame=CGRectMake(0, offsetY, CGRectGetWidth(_articleContentView.bounds), 39+contentLabelHeight);
//    
//    [view setFrame:frame];
//}

- (void)updateLastArticleViewFrame2
{
    ArticleView *view =[_articleContentView.subviews lastObject];
    CGFloat offsetY=0.f;
    if(_articleContentView.subviews.count==1){
        offsetY=12.f;
    }else{
        NSArray *viewarray =_articleContentView.subviews;
        UIView *preview=viewarray[viewarray.count-2];
        offsetY=CGRectGetMaxY(preview.frame)+12;
    }
    
    CGFloat contentLabelHeight = [view.contentLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_articleContentView.bounds)-46.f, CGFLOAT_MAX)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                                   attributes:@{NSFontAttributeName:view.contentLabel.font} context:nil].size.height;
    CGRect frame=CGRectMake(0, offsetY, CGRectGetWidth(_articleContentView.bounds), 39+contentLabelHeight);
    
    [view setFrame:frame];
}

- (void)updateLastArticleViewFrame3
{
    ArticleView *view =[_articleContentView.subviews lastObject];
    CGFloat offsetY=0.f;
    if(_articleContentView.subviews.count==1){
        offsetY=12.f;
    }else{
        NSArray *viewarray =_articleContentView.subviews;
        UIView *preview=viewarray[viewarray.count-2];
        offsetY=CGRectGetMaxY(preview.frame)+12;
    }
    
//    CGFloat contentLabelHeight = [view.contentLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(_articleContentView.bounds)-46.f, CGFLOAT_MAX)
//                                                                      options:NSStringDrawingUsesLineFragmentOrigin
//                                                                   attributes:@{NSFontAttributeName:view.contentLabel.font} context:nil].size.height;
    view.contentLabel.preferredMaxLayoutWidth=CGRectGetWidth(_articleContentView.bounds)-46.f;
    
    CGFloat contentLabelHeight = [view.contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame=CGRectMake(0, offsetY, CGRectGetWidth(_articleContentView.bounds), 39+contentLabelHeight);
    
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
