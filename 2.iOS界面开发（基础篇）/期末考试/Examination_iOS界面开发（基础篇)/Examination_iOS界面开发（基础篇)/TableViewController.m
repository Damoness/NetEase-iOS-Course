//
//  TableViewController.m
//  Examination_iOS界面开发（基础篇)
//
//  Created by wd on 2017/6/4.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "TableViewController.h"
#import "StoreFooterView.h"
#import "StoreHeaderView.h"
#import "GoodsTableViewCell.h"
#import "BottomView.h"

static NSString *STORE_HEADER_REUSED_ID = @"StoreHeaderView";
static NSString *STORE_FOOTER_REUSED_ID = @"StoreFooterView";
static NSString *GOODS_REUSED_ID = @"GoodsTableViewCell";

@interface TableViewController ()<StoreHeaderViewDelegate,GoodsTableViewCellDelegate>



@property (nonatomic) NSMutableArray<NSMutableDictionary *> *data;


@property (nonatomic) NSMutableDictionary *dataDic;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    
    
    NSString *title = [NSString stringWithFormat:@"购物车(%ld)",(long)[self getGoodsKind]];
    
    self.navigationItem.title = title;

    
    UIBarButtonItem *infoItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems = @[infoItem,editItem];
    
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    
    BottomView *bottomView = [[[NSBundle mainBundle]loadNibNamed:@"BottomView" owner:nil options:nil] lastObject];
    
    bottomView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width, 60);
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:bottomView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:STORE_HEADER_REUSED_ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreFooterView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:STORE_FOOTER_REUSED_ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsTableViewCell class]) bundle:nil] forCellReuseIdentifier:GOODS_REUSED_ID];
    
}

-(void)updateTitle{
    
    NSString *title = [NSString stringWithFormat:@"购物车(%ld)",(long)[self getGoodsKind]];
    
    self.navigationItem.title = title;
}

//获取商品种类
-(NSInteger)getGoodsKind{
    
    
    NSInteger no = 0;
    
    
    for (NSMutableDictionary *dic in self.data) {
        
       no +=[dic[@"goods"] count];
        
    }
    
    return no;
    
}

-(NSMutableArray *)data{
    
    if (_data ==nil) {
        _data = @[
                  @{@"storeName":@"自营保税仓",
                    @"selected":@false,
                    @"goods":@[@{@"name":@"德国Nanoxia奈米世界 复古打字机Ncore Retro机械键盘",
                                 @"no":@"2",
                                 @"price":@"854.0",
                                 @"image":@"机械键盘",
                                 @"selected":@false
                                       }.mutableCopy,
                               @{@"name":@"商品2",
                                 @"no":@"1",
                                 @"image":@"咖啡机",
                                 @"price":@"854.0",
                                 @"selected":@false
                                 }.mutableCopy
                               ].mutableCopy}.mutableCopy,
                  @{@"storeName":@"自营海外仓",
                    @"selected":@false,
                    @"goods":@[@{@"name":@"Dolce Gusto 多趣酷思 Genio2 Premium 胶囊咖啡机 黑色 【电压100V】",
                                 @"no":@"1",
                                 @"price":@"830.0",
                                 @"image":@"咖啡机"
                                 
                                 }.mutableCopy,
                               ].mutableCopy}.mutableCopy,
                  @{@"storeName":@"仓库3",
                    @"selected":@false,
                      @"goods":@[@{@"name":@"【海外仓发货】OMRON 欧姆龙 温热低周波脉冲便携按摩仪 HV-F021【海外分站】",
                                   @"no":@"1",
                                   @"price":@"345.0",
                                   @"image":@"OMRON"
                                   }.mutableCopy,
                                 @{@"name":@"商品2",
                                   @"no":@"1",
                                   @"price":@"854.0",
                                   @"image":@"咖啡机"
                                   }.mutableCopy,
                                 ].mutableCopy}.mutableCopy,
                  ].mutableCopy;
        
        
    }
    
    return _data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.data[section][@"goods"] count];;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    return self.data[section][@"storeName"];
//}







- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GOODS_REUSED_ID forIndexPath:indexPath];

    
    cell.delegate = self;
    
    NSMutableDictionary *goodsDic = self.data[indexPath.section][@"goods"][indexPath.row];
     
    cell.dataDic = goodsDic;
 
    //cell.dataDic
    
    return cell;
}

#pragma mark -- UITableDelegate


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    StoreHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:STORE_HEADER_REUSED_ID];
    
    headerView.storeLabel.text = self.data[section][@"storeName"];

    headerView.selected = [self.data[section][@"selected"]boolValue];
    
    headerView.section = section;
    
    headerView.delegate = self;
    
    return headerView;
    
}

-(void)storeHeaderView:(StoreHeaderView *)view checkSelect:(Boolean)selected{
    
    
    
    NSInteger section = view.section;
    
    self.data[section][@"selected"] = @(selected);
    
    
    NSMutableArray *goodsArray =  self.data[section][@"goods"];
    
    for (NSMutableDictionary *dic in goodsArray) {
        
        dic[@"selected"] = @(selected);
    }
    
 
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSLog(@"%s:selected:%@",__func__,@(selected));
    
}


-(void)goodsTableViewCell:(GoodsTableViewCell *)cell checkSelect:(Boolean)selected{
  
    
    NSLog(@"%s:selected:%@",__func__,@(selected));
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    
    self.data[indexPath.section][@"goods"][indexPath.row][@"selected"] = @(selected);
    
    if (selected) { //选中
        
        NSMutableArray *goodsArray =  self.data[indexPath.section][@"goods"];
        
        Boolean allSelected = true;
        for (NSMutableDictionary *dic in goodsArray)
        {
            
            if (![dic[@"selected"]boolValue]) {
                allSelected = false;
            }
            
        }
        
        self.data[indexPath.section][@"selected"] = @(allSelected);
        
        
    }else{ //取消选中
        
        //
        self.data[indexPath.section][@"selected"] = @(false);
    
        
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    StoreFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:STORE_FOOTER_REUSED_ID];
    
    
    
    
    
    NSMutableArray *goodsArray =  self.data[section][@"goods"];
    
    double totalNo = 0;
    
    for (NSMutableDictionary *dic in goodsArray) {
        
        if ([dic[@"selected"]boolValue]) {
            totalNo +=([dic[@"price"]floatValue] *[dic[@"no"]floatValue]);
        }
        
        
    }
    
    footerView.totalNoLabel.text = @(totalNo).stringValue;
    
    return footerView;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除" message:@"你确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
            
            NSMutableArray *goodsArray =  self.data[indexPath.section][@"goods"];
            
            [goodsArray removeObjectAtIndex:indexPath.row];
            
            
            Boolean allSelected = true;
            for (NSMutableDictionary *dic in goodsArray)
            {
                
                if (![dic[@"selected"]boolValue]) {
                    allSelected = false;
                }
                
            }
            
            self.data[indexPath.section][@"selected"] = @(allSelected);
            
            [self.tableView reloadData];
            [self updateTitle];
            
        }];
        [alert addAction:confirmAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        NSLog(@"Delete");
    }

}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return UITableViewCellEditingStyleDelete;

    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 54;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
