//
//  DatabaseTool.h
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Dish.h"
#import "OrderDish.h"



@interface DatabaseTool : NSObject
+(void)openDatabase;

+(NSArray *)selectGroupFromGroupTable;

+(NSArray *)selectDishFromMenuTableWithGroupName:(NSString *)name;

+(void)orderDishWithDish:(Dish *)dish;

+(int)selectCountFromOrderTable;

+(NSArray *)selectAllOrderDishFromOrderTable;

+(void)updataCountOfOrderDishWithDish:(OrderDish *)dish;

+(void)updataRemarkOfOrderDishWithDish:(OrderDish *)dish;

+(void)insertIntoGroup_recordTableWithANewRepast:(NSString *)date time:(NSString *)time room:(NSString *)room;

+(void)insertOrderedDishesIntoRecordTable;

+(void)deleteAllDishesFromOrderTable;


@end
