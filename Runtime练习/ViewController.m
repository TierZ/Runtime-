//
//  ViewController.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "ViewController.h"
#import "ZXDTableViewConverter.h"
#import "RuntimeListCell.h"
#import "ZXDBaseCellModel.h"
@interface ViewController ()
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)ZXDTableViewConverter * converter;
@property (nonatomic,copy)NSDictionary * vcNames;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Runtime";
    self.dataArray  = [NSMutableArray array];
    [self setupData];
    
    _vcNames = @{@"动态变量控制":@"OneVC",@"动态添加方法":@"TwoVC",@"动态交换两个方法的实现":@"ThreeVC",@"拦截并替换方法":@"FourVC",@"在方法上增加额外功能":@"FiveVC",@"实现NSCoding的自动归档和解档":@"SixVC",@"实现字典转模型的自动转换":@"SevenVC",@"实现给分类添加属性":@"EightVC"};
    
    [self setupConverter];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)setupData{
    NSArray*arr = @[@"动态变量控制",
                    @"动态添加方法",
                    @"动态交换两个方法的实现",
                    @"拦截并替换方法",
                    @"在方法上增加额外功能",
                    @"实现NSCoding的自动归档和解档",
                    @"实现字典转模型的自动转换",
                    @"实现给分类添加属性"
                    ];
    for (int i=0; i<arr.count; i++) {
        ZXDBaseCellModel *cellModel  = [ZXDBaseCellModel modelWithCellClass:[RuntimeListCell class] cellHeight:[RuntimeListCell cellHeightWithCellData:arr[i]] cellData:arr[i]];
        [self.dataArray addObject:cellModel];
    }

}

-(void)setupConverter{
    _converter = [[ZXDTableViewConverter alloc]initWithTableViewCarrier:self dataSource:self.dataArray];
    
    UITableView * table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = _converter;
    table.dataSource = _converter;
    [self.view addSubview:table];
    UIView * footV = [UIView new];
    table.tableFooterView = footV;
    
    __weak typeof(self)weakSelf = self;
   [ _converter registTableWithMethod:@selector(tableView:numberOfRowsInSection:) params:^id(NSArray *params) {
       return @(weakSelf.dataArray.count);
    }];
    
    [_converter registTableWithMethod:@selector(tableView:cellForRowAtIndexPath:) params:^id(NSArray *params) {
        UITableView *tableView = params[0];
        NSIndexPath *indexPath = params[1];
        ZXDBaseCellModel *cellModel = weakSelf.dataArray[indexPath.row];
        ZXDBaseCell *cell = [tableView cellForIndexPath:indexPath cellClass:[cellModel.cellClass class]];
        [cell setCellData:cellModel.cellData];
        return cell;
     }];
    [_converter registTableWithMethod:@selector(tableView:heightForRowAtIndexPath:) params:^id(NSArray *params) {
         NSIndexPath *indexPath = params[1];
        ZXDBaseCellModel *cellModel = weakSelf.dataArray[indexPath.row];

        return @(cellModel.cellHeight);
    }];
    
    [_converter registTableWithMethod:@selector(tableView:didSelectRowAtIndexPath:) params:^id(NSArray *params) {
        NSIndexPath *indexPath = params[1];
        ZXDBaseCellModel *cellModel = weakSelf.dataArray[indexPath.row];
        NSString * vcNameKey =(NSString*) cellModel.cellData;
        Class nextClass = NSClassFromString(weakSelf.vcNames [vcNameKey]);
        BaseVC * nextVC = [nextClass new];
        nextVC.navigationItem.title = vcNameKey;
        [self.navigationController pushViewController:nextVC animated:YES];
        return nil;
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
