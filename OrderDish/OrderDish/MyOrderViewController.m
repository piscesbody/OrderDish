//
//  MyOrderViewController.m
//  OrderDish
//
//  Created by 陈宁 on 2017/5/1.
//  Copyright © 2017年 陈宁. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "SendOrderViewController.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UILabel *_priceLabel;
    IBOutlet UITableView *_tableView;
    
    NSMutableArray *_dataArray;
}

@end

@implementation MyOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_dataArray setArray:[DatabaseTool selectAllOrderDishFromOrderTable]];
    [_tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray setArray:[DatabaseTool selectAllOrderDishFromOrderTable]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self resetPriceLabel];
}

- (IBAction)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sendOrderButtonClick:(id)sender {
    SendOrderViewController *sendVC = [[SendOrderViewController alloc]init];
    [self presentViewController:sendVC animated:YES completion:nil];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    OrderDish *orderDish = [_dataArray objectAtIndex:indexPath.row];
    cell.IDLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.nameLabel.text = orderDish.menuName;
    cell.priceLabel.text = [NSString stringWithFormat:@"%d",orderDish.price];
    cell.countField.text = [NSString stringWithFormat:@"%d",orderDish.menuNum];
    cell.kindLabel.text = orderDish.kind;
    cell.remarkField.text = orderDish.remark;
    
    cell.countField.tag = indexPath.row+2000;
    [cell.remarkField addTarget:self action:@selector(remarkFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
    return cell;
}

-(void)countFieldChanged:(UITextField *)textField
{
    OrderDish *orderDish = [_dataArray objectAtIndex:textField.tag-20];
    if (textField.text.intValue <=0) {
        textField.text = [NSString stringWithFormat:@"%d",orderDish.menuNum];
        return;
    }
    orderDish.menuNum = textField.text.intValue;
    [DatabaseTool updataCountOfOrderDishWithDish:orderDish];
    [self resetPriceLabel];
}
-(void)remarkFieldChanged:(UITextField *)textField
{
    OrderDish *orderDish = [_dataArray objectAtIndex:textField.tag-2000];
    if (textField.text.length <=0) {
        textField.text = [NSString stringWithFormat:@"%@",orderDish.remark];
        return;
    }
    orderDish.remark = textField.text;
    [DatabaseTool updataRemarkOfOrderDishWithDish:orderDish];
}

-(void)resetPriceLabel
{
    int allPrice = 0;
    for (OrderDish *dish in _dataArray) {
        allPrice = dish.price*dish.menuNum+allPrice;
    }
    _priceLabel.text = [NSString stringWithFormat:@"%d",allPrice];
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
