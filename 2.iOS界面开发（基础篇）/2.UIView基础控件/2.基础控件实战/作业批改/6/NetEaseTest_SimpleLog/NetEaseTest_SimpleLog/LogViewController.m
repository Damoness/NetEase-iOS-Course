//
//  LogViewController.m
//  NetEaseTest_SimpleLog
//
//  Created by _Sharuru on 2017/6/2.
//  Copyright © 2017年 KarinoSharuru. All rights reserved.
//

#import "LogViewController.h"
#import "LogModel.h"
#import "LogCollectionViewCell.h"

@interface LogViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray<LogModel *> *modelArray;

@end

@implementation LogViewController

- (NSMutableArray<LogModel *> *)modelArray {
    if (_modelArray == nil) {
        _modelArray = @[].mutableCopy;
    }
    return _modelArray;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor colorWithRed:23 / 255.0 green:23 / 255.0 blue:23 / 255.0 alpha:1]}];
    self.title = @"我的主页";
    _inputTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _inputTextField.leftViewMode = UITextFieldViewModeAlways;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LogCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([LogCollectionViewCell class])];
    self.collectionView.collectionViewLayout = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 12;
        layout.sectionInset = UIEdgeInsetsMake(12, 0, 12, 0);
        layout;
    });
}

#pragma mark - Actions
- (IBAction)handlePublishBtnClick:(id)sender {
    if (_inputTextField.text.length > 0) {
        LogModel *model = [[LogModel alloc] initWithContent:_inputTextField.text];
        [self.modelArray addObject:model];
        [self.collectionView reloadData];
        _inputTextField.text = @"";
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LogCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LogCollectionViewCell class]) forIndexPath:indexPath];
    cell.model = self.modelArray[indexPath.item];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    LogModel *model = self.modelArray[indexPath.item];
    NSLog(@"%ld : %f", indexPath.item, model.height);
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, model.height);
}

@end
