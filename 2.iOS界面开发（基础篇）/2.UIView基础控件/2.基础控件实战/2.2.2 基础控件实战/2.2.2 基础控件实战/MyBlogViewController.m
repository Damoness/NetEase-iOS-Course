//
//  MyBlogViewController.m
//  2.2.2 基础控件实战
//
//  Created by 吴狄 on 2017/5/20.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "MyBlogViewController.h"
#import "ArticleView.h"

@interface MyBlogViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *inputImageView;
@property (weak, nonatomic) IBOutlet UIButton *issueButton;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;


@property (weak, nonatomic) IBOutlet UIView *contentView;


@end

@implementation MyBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViews];

}

-(void)initViews{
    
    
    UIImage *inputBgImage = [_inputImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 20, 12, 20) resizingMode:UIImageResizingModeStretch];
    
    
    _inputImageView.image  = inputBgImage;
    
    
    
   UIImage *issueButtonBgImage =  [[UIImage imageNamed:@"button-green" ] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15) resizingMode:UIImageResizingModeStretch];
    
    
    [self.issueButton setBackgroundImage:issueButtonBgImage forState:UIControlStateNormal];
    
    

    
    
}


- (IBAction)postButtonAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (self.inputTextField.text.length == 0) {
        return;
    }
    
    ArticleView *articleView =   [[[UINib nibWithNibName:@"ArticleView" bundle:nil ]instantiateWithOwner:nil options:nil] firstObject];;
    
    
    NSDate *currentDate = [NSDate date];
    
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc]init];
    
    [dateFomatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *timeString = [dateFomatter stringFromDate:currentDate];
    

    articleView.dateLabel.text = timeString;
    articleView.contentLabel.text = self.inputTextField.text;
    
    [self.contentView addSubview:articleView];
    
    
    [self updateLastArticleViewConstraints];
    
    [articleView setTransform:CGAffineTransformMakeScale(0, 0)];
    
    [UIView animateWithDuration:2.f animations:^{
       
        [articleView setTransform:CGAffineTransformIdentity];
    }];
    
}


-(void)updateLastArticleViewConstraints{
    
    
    
    ArticleView *articleView = self.contentView.subviews.lastObject;
    [articleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    if (self.contentView.subviews.count == 1) {
    
        NSLayoutConstraint *topConstraints = [NSLayoutConstraint constraintWithItem:articleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1 constant:12];
        
        
        [_contentView addConstraint:topConstraints];
        
    }else{
        
        ArticleView *preView = self.contentView.subviews[self.contentView.subviews.count - 2];
        
        NSLayoutConstraint *topConstraints = [NSLayoutConstraint constraintWithItem:articleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:preView attribute:NSLayoutAttributeBottom multiplier:1 constant:12];
        
        
        [_contentView addConstraint:topConstraints];
        
    }
    
    NSLayoutConstraint *leftConstrains = [NSLayoutConstraint constraintWithItem:articleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    
    NSLayoutConstraint *rightConstrains = [NSLayoutConstraint constraintWithItem:articleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    
    
    [_contentView addConstraints:@[leftConstrains,rightConstrains]];
    
    
    
    
}

-(void)updateLastArticleViewFrame{
    
    ArticleView *articleView  = self.contentView.subviews.lastObject;
    CGFloat offsetY = 0;
    
    if (self.contentView.subviews.count == 1) {
        
        offsetY = 12;
        
    }else{
        
        
        NSArray *subViews = self.contentView.subviews;
        
        UIView *preView = subViews[subViews.count -2];
        
        offsetY = CGRectGetMaxY(preView.frame) + 12;
        
    }
    
    CGFloat contentHeight  = [articleView.contentLabel sizeThatFits:CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) - 46, CGFLOAT_MAX)].height;
    
    CGRect frame = CGRectMake(0, offsetY, UIScreen.mainScreen.bounds.size.width, 39 + contentHeight);
    
    articleView.frame = frame;
    
    
}

-(void)updateLastArticleViewFrame2{
    
    ArticleView *articleView  = self.contentView.subviews.lastObject;
    CGFloat offsetY = 0;
    
    if (self.contentView.subviews.count == 1) {
        
        offsetY = 12;
        
    }else{
        
        
        NSArray *subViews = self.contentView.subviews;
        
        UIView *preView = subViews[subViews.count -2];
        
        offsetY = CGRectGetMaxY(preView.frame) + 12;
        
    }
    
    
    CGSize size = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) - 46, CGFLOAT_MAX);
    
    CGFloat contentHeight  = [articleView.contentLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:articleView.contentLabel.font} context:nil].size.height;
    CGRect frame = CGRectMake(0, offsetY, UIScreen.mainScreen.bounds.size.width, 39 + contentHeight);
    
    articleView.frame = frame;
    
    
}


-(void)updateLastArticleViewFrame3{
    
    ArticleView *articleView  = self.contentView.subviews.lastObject;
    CGFloat offsetY = 0;
    
    if (self.contentView.subviews.count == 1) {
        
        offsetY = 12;
        
    }else{
        
        
        NSArray *subViews = self.contentView.subviews;
        
        UIView *preView = subViews[subViews.count -2];
        
        offsetY = CGRectGetMaxY(preView.frame) + 12;
        
    }
    
    
    
    CGSize size = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) - 46, CGFLOAT_MAX);
    
    
    articleView.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(UIScreen.mainScreen.bounds) - 46;
    
    CGFloat contentHeight  = [articleView.contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = CGRectMake(0, offsetY, UIScreen.mainScreen.bounds.size.width, 39 + contentHeight);
    
    articleView.frame = frame;
    
    
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
