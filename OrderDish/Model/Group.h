//
//  Group.h
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
@property (nonatomic, assign) int groupID;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *hilightedImage;

@end
