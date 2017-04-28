//
//  CommonTool.m
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+(void)changeRootViewControllerWithController:(UIViewController *)viewController
{
    KEY_WINDOW.rootViewController = viewController;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:5 forView:KEY_WINDOW cache:YES];
    [UIView commitAnimations];
}

+(void)flipCellWithCell:(UITableViewCell *)cell
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell cache:YES];
    [UIView commitAnimations];
}

@end
