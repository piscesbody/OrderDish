//
//  Dish.h
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dish : NSObject
@property (nonatomic, assign) int dishID;
@property (nonatomic, assign) int groupID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iKind;
@property (nonatomic, assign) int price;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *picName;

@end
