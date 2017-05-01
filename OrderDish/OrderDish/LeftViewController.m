//
//  LeftViewController.m
//  OrderDish
//
//  Created by 陈宁 on 2017/4/29.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import "LeftViewController.h"
#import "DetailViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_sectionArray;
    int long _selectSection;
    NSMutableArray *_dishArray;
    int long _selectRow;
    
    UIImageView *_dishImageView;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldicon.png",self.index+1]];
    _sectionArray = [[NSMutableArray alloc]init];
    NSArray *array = [DatabaseTool selectGroupFromGroupTable];
    NSString *sectionStr = [[array objectAtIndex:self.index]name];
    [_sectionArray setArray:[sectionStr componentsSeparatedByString:@"|" ]];
    _dishArray = [[NSMutableArray alloc]initWithCapacity:_sectionArray.count];
    for (int i = 0; i<_sectionArray.count; i++) {
        NSString *name = [_sectionArray objectAtIndex:i];
        NSArray *array = [DatabaseTool selectDishFromMenuTableWithGroupName:name];
        [_dishArray addObject:array];
    }
    _dishTableView.delegate = self;
    _dishTableView.dataSource = self;
    _dishTableView.backgroundColor = [UIColor clearColor];
    _dishTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    _dishScrollView.alwaysBounceVertical = NO;
    _dishScrollView.alwaysBounceHorizontal = YES;
    _dishScrollView.pagingEnabled = YES;
    _dishScrollView.delegate = self;
    
    [self resetDishScrollView];
    [self resetCountLabel];
    
}

-(void)resetDishScrollView
{
    NSArray *array = [_dishArray objectAtIndex:_selectSection];
    _dishScrollView.contentSize = CGSizeMake(_dishScrollView.frame.size.width*array.count, _dishScrollView.frame.size.height);
    for (UIView *view in [_dishScrollView subviews]) {
        [view removeFromSuperview];
    }
    for (int i = 0; i <array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_dishScrollView.frame.size.width, 0, _dishScrollView.frame.size.width, _dishScrollView.frame.size.height)];
        imageView.image = [UIImage imageNamed:[[array objectAtIndex:i]picName]];
        [_dishScrollView addSubview:imageView];
    }
    [_dishScrollView setContentOffset:CGPointMake(0, 0)];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectSection == section) {
        return [[_dishArray objectAtIndex:section]count];
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line32"]];
        imageView.frame = cell.frame;
        imageView.tag = 5;
        [cell.contentView addSubview:imageView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:5];
    if (_selectRow == indexPath.row) {
        imageView.hidden = NO;
    }else{
        imageView.hidden = YES;
    }
    
    Dish *dish = [[_dishArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.text = dish.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d元/%@",dish.price,dish.unit];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor yellowColor];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:[_sectionArray objectAtIndex:section] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    button.tag = section+1000;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"line33"] forState:UIControlStateNormal];
    return button;
}
-(void)buttonClick:(UIButton *)sender
{
    if (_selectSection == sender.tag-1000) {
        return;
    }
    _selectRow = 0;
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    [set addIndex:_selectSection];
    _selectSection = sender.tag-1000;
    [set addIndex:_selectSection];
    [_dishTableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    [self resetDishScrollView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectRow = indexPath.row;
    [_dishTableView reloadData];
    UITableViewCell *cell = [_dishTableView cellForRowAtIndexPath:indexPath];
    [CommonTool flipCellWithCell:cell];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _selectRow = _dishScrollView.contentOffset.x/_dishScrollView.frame.size.width;
    [_dishTableView reloadData];
    UITableViewCell *cell = [_dishTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:_selectSection]];
    [CommonTool flipCellWithCell:cell];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSArray *array = [[_dishArray objectAtIndex:_selectSection]objectAtIndex:_selectRow];
    if (_dishScrollView.contentOffset.x<0||_dishScrollView.contentOffset.x>(array.count-1)*_dishScrollView.frame.size.width) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"已经没有菜了" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (IBAction)detailButtonClick:(id)sender {
    Dish *dish = [[_dishArray objectAtIndex:_selectSection]objectAtIndex:_selectRow];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.dish = dish;
    detailVC.modalPresentationStyle = UIModalPresentationFormSheet;
    detailVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:detailVC animated:YES completion:nil];
}
- (IBAction)myOrderButtonClick:(id)sender {
    MyOrderViewController *myOrderVC = [[MyOrderViewController alloc]init];
    [self presentViewController:myOrderVC animated:YES completion:nil];
}
- (IBAction)orderButtonClick:(id)sender {
    Dish *dish = [[_dishArray objectAtIndex:_selectSection]objectAtIndex:_selectRow];
    if (!_dishImageView) {
        _dishImageView = [[UIImageView alloc]init];
        [self.view addSubview:_dishImageView];
    }
    _dishImageView.frame = _dishScrollView.frame;
    _dishImageView.alpha = 1;
    _dishImageView.image = [UIImage imageNamed:dish.picName];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    _dishImageView.frame = _countLabel.frame;
    _dishImageView.alpha = 0;
    [UIView commitAnimations];
    
    [DatabaseTool orderDishWithDish:dish];
    [self resetCountLabel];
}

-(void)resetCountLabel
{
    _countLabel.text = [NSString stringWithFormat:@"已经点了%d道菜",[DatabaseTool selectCountFromOrderTable]];
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
