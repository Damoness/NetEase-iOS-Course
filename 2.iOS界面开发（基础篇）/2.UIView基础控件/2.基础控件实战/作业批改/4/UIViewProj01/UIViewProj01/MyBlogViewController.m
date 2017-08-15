//
//  MyBlogViewController.m
//  UIViewProj01
//
//  Created by huangchenpeng on 2017/6/4.
//  Copyright © 2017年 ChamberH. All rights reserved.
//

#import "MyBlogViewController.h"
#import "ArticleView.h"

@interface MyBlogViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *textBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIView *articleContentView;

@end

@implementation MyBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *inputBgImage = [_textBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12) resizingMode:UIImageResizingModeStretch];
    [_textBgImageView setImage:inputBgImage];

    UIImage *buttongBgImage = [[UIImage imageNamed:@"button-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_postButton setBackgroundImage:buttongBgImage forState:UIControlStateNormal];
    
}


- (IBAction)postButtonAction:(id)sender {
    ArticleView *view = [[[UINib nibWithNibName:@"ArticleView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    //ArticleView *view = [[ArticleView alloc] init];
    view.nameLabel.text = @"w";
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    view.dateLabel.text =  [formatter stringFromDate:date];;
    view.contentLabel.text = _textField.text;
    [_articleContentView addSubview:view];
    
    [self updateLastArticleViewFrame];
}

- (void)updateLastArticleViewFrame{
    ArticleView *view = [_articleContentView.subviews lastObject];
    CGFloat offsetY = 0;
    if (_articleContentView.subviews.count == 1) {
        offsetY = 12.0f;
    }
    else{
        NSArray *views = _articleContentView.subviews;
        UIView *preView = views[views.count - 2];
        offsetY = CGRectGetMaxY(preView.frame) + 12;
    }
    CGFloat contentLabelHeight = [view.contentLabel sizeThatFits:CGSizeMake(CGRectGetWidth(_articleContentView.bounds) - 46, CGFLOAT_MAX)].height;
    CGRect frame = CGRectMake(0, offsetY, CGRectGetWidth(_articleContentView.bounds), 39 + contentLabelHeight);
    view.frame = frame;
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
