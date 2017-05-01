//
//  DetailViewController.h
//  OrderDish
//
//  Created by 陈宁 on 2017/5/1.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dish.h"

@interface DetailViewController : UIViewController
{
    IBOutlet UILabel *_titleLabel;
    IBOutlet UIImageView *_imageView;
}
@property (nonatomic,retain)Dish *dish;

@end
