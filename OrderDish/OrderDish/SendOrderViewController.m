//
//  SendOrderViewController.m
//  OrderDish
//
//  Created by 陈宁 on 2017/4/30.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import "SendOrderViewController.h"
#import "ChooseRoomViewController.h"


@interface SendOrderViewController ()<ChooseRoomViewControllerDelegate>
{
    IBOutlet UIButton *_roomButton;
}

@end

@implementation SendOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendOrderButtonClick:(id)sender {
    if (_roomButton.titleLabel.text.length<=0) {
        ALERT_VIEW(@"请选择房间");
        return;
    }
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *date= [formatter stringFromDate:now];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *time = [formatter stringFromDate:now];
    NSString *room = _roomButton.titleLabel.text;
    
    [DatabaseTool insertIntoGroup_recordTableWithANewRepast:date time:time room:room];
    
    [DatabaseTool insertOrderedDishesIntoRecordTable];
    
    [DatabaseTool deleteAllDishesFromOrderTable];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)chooseRoomButtonClick:(id)sender {
    ChooseRoomViewController *chooseRoom = [[ChooseRoomViewController alloc]init];
    
    chooseRoom.delegate = self;
    [self presentViewController:chooseRoom animated:YES completion:nil];
}

-(void)chooseRoomWithRoomName:(NSString *)roomName
{
    [_roomButton setTitle:roomName forState:UIControlStateNormal];
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

@end
