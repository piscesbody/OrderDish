//
//  CommonTool.h
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonTool : NSObject

+(void)changeRootViewControllerWithController:(UIViewController *)viewController;
+(void)flipCellWithCell:(UITableViewCell *)cell;

@end
