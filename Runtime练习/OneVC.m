//
//  OneVC.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "OneVC.h"
#import "Person.h"
#import <objc/runtime.h>
@interface OneVC ()
@property (nonatomic,strong)Person * person;
@property (nonatomic,strong)UILabel * lab2;
@end

@implementation OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person new];
    self.person.name = @"小明";

    UILabel * lab1 = [UILabel new];
    lab1.frame = CGRectMake(50, 100, 100, 30);
    lab1.text = [NSString stringWithFormat:@"我是%@",self.person.name];
    [self.view addSubview:lab1];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 20);
    [btn setTitle:self.navigationItem.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeIvar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.lab2 =  [UILabel new];
     self.lab2.frame = CGRectMake(50, 300, 200, 30);
     self.lab2.text = @"我还没变";
    [self.view addSubview: self.lab2];
    
    // Do any additional setup after loading the view.
}
-(void)changeIvar{
    unsigned int count = 0;
//    获得某个类的所有成员变量（outCount 会返回成员变量的总数）
//    参数：
//    1、哪个类
//    2、放一个接收值的地址，用来存放属性的个数
//    3、返回值：存放所有获取到的属性，通过下面两个方法可以调出名字和类型
    Ivar * ivars = class_copyIvarList([Person class], &count);
    Method * methods = class_copyMethodList([Person class], &count);//获得所有方法
    objc_property_t * propertys = class_copyPropertyList([Person class], &count);//获得所有属性
    __unsafe_unretained Protocol ** protocals = class_copyProtocolList([Person class], &count);//获得所有协议
    for (int i = 0; i<count; i++) {
        Ivar var = ivars[i];
        //获取变量的名字
        const char * varName = ivar_getName(var);
        NSString * ivarStr = [NSString stringWithUTF8String:varName];
        NSLog(@"ivarStr = %@",ivarStr);
//        获得成员变量的类型
        const char * varType =  ivar_getTypeEncoding(var);
        NSString * ivarTypeStr = [NSString stringWithUTF8String:varType];
        NSLog(@"ivarTypeStr = %@",ivarTypeStr);
        
        if ([ivarStr isEqualToString:@"_name"]) {//要给属性加下划线
            object_setIvar(self.person, var, @"小明的哥哥");
//            break;
        }
    }
    free(ivars);
    self.lab2.text = [NSString stringWithFormat:@"我是%@",self.person.name];
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
