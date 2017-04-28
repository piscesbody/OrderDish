//
//  SelectViewController.m
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import "SelectViewController.h"
#import "MainViewController.h"
#import "WelcomeViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goToMainVC:(id)sender {
    MainViewController *mainVC = [[MainViewController alloc]init];
    [CommonTool changeRootViewControllerWithController:mainVC];
}

- (IBAction)goBackWelcomeVC:(id)sender {
    WelcomeViewController *welcomeVC = [[WelcomeViewController alloc]init];
    [CommonTool changeRootViewControllerWithController:welcomeVC];
}

- (IBAction)goToHistoryVC:(id)sender {
}
@end
