//
//  MyBlogViewController.m
//  MyBlog
//
//  Created by jele lam on 2/6/2017.
//  Copyright © 2017年 jele lam. All rights reserved.
//

#import "MyBlogViewController.h"
#import "articleView.h"

@interface MyBlogViewController ()
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIImageView *textBgImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *articleContentView;

@end

@implementation MyBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *inputImage = [_textBgImageView.image resizableImageWithCapInsets:UIEdgeInsetsMake(12, 22, 12, 22) resizingMode:UIImageResizingModeStretch];
    [_textBgImageView setImage:inputImage];
    
    UIImage *buttonBgImage = [[UIImage imageNamed:@"button-green"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [_postButton setBackgroundImage:buttonBgImage forState:UIControlStateNormal];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postButtonAction:(id)sender {
    [self.view endEditing:YES];
    if (_textField.text.length == 0 ) {
        return ;
    }
    articleView *view = [[[UINib nibWithNibName:@"articleView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    [view.nameLabel setText:@"cooljele"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    [view.dateLabel setText:[dateFormatter stringFromDate:[NSDate date]]];
    [view.contentLabel setText:_textField.text];
    [_articleContentView addSubview:view];
    [self updateLastArticleViewFrame];

}

- (void)updateLastArticleViewFrame {
    articleView *view = [_articleContentView.subviews lastObject];
    CGFloat offsetY = 0;
    if (_articleContentView.subviews.count ==1) {
        offsetY = 12.f;
    } else {
        NSArray *viewArray = _articleContentView.subviews;
        UIView *preView = viewArray[viewArray.count - 2];
        offsetY = CGRectGetMaxY(preView.frame) + 12;
    }
    view.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(_articleContentView.bounds) - 46.f;
    CGFloat contentLabelHeight = [view.contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = CGRectMake(0, offsetY, CGRectGetWidth(_articleContentView.bounds), 39 + contentLabelHeight);
    [view setFrame:frame];
    
}

@end
