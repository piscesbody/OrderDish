//
//  ChooseRoomViewController.h
//  OrderDish
//
//  Created by 陈宁 on 2017/4/30.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseRoomViewController : UIViewController
@property (nonatomic, assign) id delegate;

@end
@protocol ChooseRoomViewControllerDelegate <NSObject>

-(void)chooseRoomWithRoomName:(NSString *)roomName;

@end
