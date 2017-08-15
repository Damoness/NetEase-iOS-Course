//
//  ViewController.m
//  OCFoundation
//
//  Created by 吴狄 on 2017/4/19.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import "ViewController.h"

//typedef enum : NSUInteger {
//    <#MyEnumValueA#>,
//    <#MyEnumValueB#>,
//    <#MyEnumValueC#>,
//} <#MyEnum#>;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSMutableArray *array = @[@1,@2,@3,@4].mutableCopy;
    
    
    //[array removeObjectsInRange:NSMakeRange(2, 2)];
    
    
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:1];
    
    [indexSet addIndex:3];
    
    
    [array removeObjectsAtIndexes:indexSet];
    
    NSLog(@"%@",array);

    
    
}


- (void)setRepresentedObject:(id)representedObject {
    // Update the view, if already loaded.
    [super setRepresentedObject:representedObject];

}


@end
