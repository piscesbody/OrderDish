//
//  DatabaseTool.m
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import "DatabaseTool.h"
#import "Group.h"

@implementation DatabaseTool

FMDatabase *_database;

+(void)openDatabase
{
    NSString *path = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/database.sqlite"];
    _database = [[FMDatabase alloc]initWithPath:path];
    
    if ([_database open]) {
        NSLog(@"打开数据库成功");
    }
}

+(NSArray *)selectGroupFromGroupTable
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = @"select *from groupTable";
    FMResultSet *set = [_database executeQuery:sql];
    while ([set next]) {
        Group *group = [[Group alloc]init];
        group.groupID = [set intForColumnIndex:0];
        group.kind = [set stringForColumnIndex:1];
        group.name = [set stringForColumnIndex:2];
        group.image = [set stringForColumnIndex:3];
        group.hilightedImage = [set stringForColumnIndex:4];
        [array addObject:group];
    }
    [set close];
    return array;
}

+(NSArray *)selectDishFromMenuTableWithGroupName:(NSString *)name
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select *from menuTable where iKind = '%@'",name];
    FMResultSet *set = [_database executeQuery:sql];
    while ([set next]) {
        Dish *dish = [[Dish alloc]init];
        dish.dishID = [set intForColumnIndex:0];
        dish.groupID = [set intForColumnIndex:1];
        dish.iKind = [set stringForColumnIndex:2];
        dish.name = [set stringForColumnIndex:3];
        dish.price = [set intForColumnIndex:4];
        dish.unit = [set stringForColumnIndex:5];
        dish.detail = [set stringForColumnIndex:6];
        dish.picName = [set stringForColumnIndex:7];
        [array addObject:dish];
    }
    [set close];
    return [NSArray arrayWithArray:array];
}

+(void)orderDishWithDish:(Dish *)dish
{
    NSString *sql = [NSString stringWithFormat:@"select *from orderTable where id = %d",dish.dishID];
    FMResultSet *set = [_database executeQuery:sql];
    if ([set next]) {
        int count = [set intForColumn:@"menuNum"];
        sql = [NSString stringWithFormat:@"updata orderTable set menuNum = %d where id = %d",count+1,dish.dishID];
        [_database executeUpdate:sql];
    }else{
        sql = [NSString stringWithFormat:@"insert into orderTable values (%d,'%@',%d,'%@',%d,'%@')",dish.dishID,dish.name,dish.price,dish.iKind,1,@""];
        [_database executeUpdate:sql];
    }
    [set close];
}

+(int)selectCountFromOrderTable
{
    NSString *sql = @"select count(*) from orderTable";
    FMResultSet *set = [_database executeQuery:sql];
    [set next];
    int count = [set intForColumnIndex:0];
    [set close];
    return count;
}

+ (NSArray *)selectAllOrderDishFromOrderTable
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = @"select * from orderTable";
    FMResultSet *set = [_database executeQuery:sql];
    while ([set next]) {
        OrderDish *orderDish = [[OrderDish alloc]init];
        orderDish.orderDishID = [set intForColumnIndex:0];
        orderDish.menuName = [set stringForColumnIndex:1];
        orderDish.price = [set intForColumnIndex:2];
        orderDish.kind = [set stringForColumnIndex:3];
        orderDish.menuNum = [set intForColumnIndex:4];
        orderDish.remark = [set stringForColumnIndex:5];
        [array addObject:orderDish];
    }
    [set close];
    return array;
}



+(void)updataCountOfOrderDishWithDish:(OrderDish *)dish
{
    NSString *sql = [NSString stringWithFormat:@"updata orderTable set menuNum = %d where id = %d",dish.menuNum,dish.orderDishID];
    [_database executeUpdate:sql];
}

+(void)updataRemarkOfOrderDishWithDish:(OrderDish *)dish
{
    NSString *sql = [NSString stringWithFormat:@"updata orderTable set remark = '%@' where id = %d",dish.remark,dish.orderDishID];
    [_database executeUpdate:sql];
}

+(void)insertIntoGroup_recordTableWithANewRepast:(NSString *)date time:(NSString *)time room:(NSString *)room
{
    NSString *sql = [NSString stringWithFormat:@"insert into group_recordTable (date,time,room) values ('%@','%@','%@')",date,time,room];
    [_database executeUpdate:sql];
}

+(void)insertOrderedDishesIntoRecordTable
{
    NSArray *array = [DatabaseTool selectAllOrderDishFromOrderTable];
    
    NSString *sql = @"select max(id) from group_recordTable";
    FMResultSet *set = [_database executeQuery:sql];
    [set next];
    int maxID = [set intForColumnIndex:0];
    [set close];
    
    for (OrderDish *dish in array) {
        NSString *sql = [NSString stringWithFormat:@"insert into recordTable (stateNum,menuName,menyPrice,menuKind,menuNum,menuRemark,groupID) values (0,'%@',%d,'%@',%d,'%@',%d)",dish.menuName,dish.price,dish.kind,dish.menuNum,dish.remark,maxID];
        [_database executeUpdate:sql];
    }
}

+(void)deleteAllDishesFromOrderTable
{
    NSString *sql = @"delete from orderTable";
    [_database executeUpdate:sql];
}

@end
