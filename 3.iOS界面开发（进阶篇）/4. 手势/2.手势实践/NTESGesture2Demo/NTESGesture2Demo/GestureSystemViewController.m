//
//  GestureSystemViewController.m
//  Gesture2Demo
//
//  Created by jeunfung on 16/9/28.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "GestureSystemViewController.h"

@interface TestScrollView : UIScrollView<UIGestureRecognizerDelegate>

@end

@implementation TestScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"])
    {
        return NO;
    }
    return YES;
}

@end

@interface GestureSystemViewController()<UITableViewDelegate, UITableViewDataSource>
{
    //demo5.1
    UIView *_testView;
    UIScreenEdgePanGestureRecognizer *_edgePan;
    
    //demo5.2
//    UIScrollView *_scrollView;
    TestScrollView *_scrollView;
    UITableView *_tableView;
}

@end

@implementation GestureSystemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //demo5.1
    _testView = [[UIView alloc] init];
    _testView.backgroundColor = [UIColor orangeColor];
    _testView.frame = CGRectMake(50, 50, 150, 150);
    [self.view addSubview:_testView];
    
    _edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    _edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_edgePan];
    
    [self.navigationController.interactivePopGestureRecognizer requireGestureRecognizerToFail:_edgePan];

    //demo5.2
//    _scrollView = [[UIScrollView alloc] init];
    _scrollView = [[TestScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.frame = CGRectMake(50, 250, 300, 300);
    _scrollView.contentSize = CGSizeMake(1000, 300);
    [self.view addSubview:_scrollView];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 10, 300, 280);
    [_scrollView addSubview:_tableView];
}

#pragma mark - pan
- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translatePoint = [gesture translationInView:self.view];
        _testView.center = CGPointMake(_testView.center.x + translatePoint.x, _testView.center.y);
        [gesture setTranslation:CGPointZero inView:self.view];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        _testView.frame = CGRectMake(50, 50, 150, 150);
    }
}


#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell %zd", indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
