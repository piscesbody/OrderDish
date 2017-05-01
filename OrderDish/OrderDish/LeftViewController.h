//
//  LeftViewController.h
//  OrderDish
//
//  Created by 陈宁 on 2017/4/29.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UITableView *dishTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *dishScrollView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (nonatomic, assign) int long index;
-(void)resetCountLabel;


@end
