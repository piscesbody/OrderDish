//
//  MainViewController.m
//  OrderDish
//
//  Created by 陈宁 on 2017/4/28.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import "MainViewController.h"
#import "SelectViewController.h"
#import "Group.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
    int _selectRow;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = [[NSArray alloc]initWithArray:[DatabaseTool selectGroupFromGroupTable]];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.rowHeight = 95;
    //TODO: 创建七个视图控制器，显示左侧表对应的数据
    
    [self.view bringSubviewToFront:_rightTableView];
    [self.view bringSubviewToFront:_BackButton];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    Group *group = _dataArray[indexPath.row];
    if (_selectRow == indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:group.hilightedImage];
    }else{
        cell.imageView.image = [UIImage imageNamed:group.image];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectRow = indexPath.row;
    [_rightTableView reloadData];
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

- (IBAction)backButton:(UIButton *)sender {
    SelectViewController *selectVC = [[SelectViewController alloc]init];
    [CommonTool changeRootViewControllerWithController:selectVC];
}
@end
