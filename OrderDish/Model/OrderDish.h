//
//  OrderDish.h
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDish : NSObject
@property (nonatomic, assign) int orderDishID;
@property (nonatomic, assign) int price;
@property (nonatomic, assign) int menuNum;
@property (nonatomic, copy) NSString *menuName;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *remark;


@end
