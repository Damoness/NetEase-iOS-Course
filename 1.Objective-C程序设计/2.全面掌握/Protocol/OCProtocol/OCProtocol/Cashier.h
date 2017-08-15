//
//  Cashier.h
//  OCProtocol
//
//  Created by 吴狄 on 2017/4/19.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fruit.h"
#import "FruitHelper.h"

@interface Cashier:NSObject

-(instancetype)initWithFruits:(NSArray<Fruit *> *)fruits;

-(CGFloat)checkOut;


@end
