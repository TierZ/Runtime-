//
//  ThreeVC.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "ThreeVC.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ThreeVC ()
@property (nonatomic,strong)Person * person;

@end

@implementation ThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person new];
    [self.person sayName];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.person sayHello];
    });
    
    UILabel * lab = [UILabel new];
    lab.text = @"结果看控制台打印内容";
    lab.frame = CGRectMake(100, 100, 300, 30);
    [self.view addSubview:lab];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 20);
    [btn setTitle:self.navigationItem.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeSelector) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    // Do any additional setup after loading the view.
}

-(void)changeSelector{
    Method  selector1 = class_getInstanceMethod([self.person class], @selector(sayName));
    Method selector2 = class_getInstanceMethod([self.person class], @selector(sayHello));
    
    method_exchangeImplementations(selector1, selector2);
    NSLog(@"交换方法");
    [self.person sayName];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.person sayHello];
    });


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
