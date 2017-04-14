//
//  FourVC.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "FourVC.h"

@interface FourVC ()

@end

@implementation FourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这里 修改的是 image 的 imageNamed: 方法 ， 通过在image的分类里 写新的方法  来替换原先系统的 imageNamed  方法
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    iv.backgroundColor = [UIColor redColor];
    iv.image = [UIImage imageNamed:@"picon.jpg"];
    [self.view addSubview:iv];

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
