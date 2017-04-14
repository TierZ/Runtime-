//
//  TwoVC.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "TwoVC.h"
#import <objc/runtime.h>
@interface TwoVC ()

@end

@implementation TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 20);
    [btn setTitle:self.navigationItem.title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(callUnDefineSelector) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)callUnDefineSelector{
    [self performSelector:@selector(unDefinedMethod)];
    
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    //这里自行判断
    class_addMethod([self class], sel, (IMP)callWrongMethod, "v@:");
    return YES;
}

+(BOOL)resolveClassMethod:(SEL)sel{
    return NO;
}

void callWrongMethod(id self,SEL _cmd){
    
    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:@"提示" message:@"你不能调用我，我没被定义呢,我只能自己创建一个方法，通知你一下" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定啊" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
    }];
     [alertvc addAction:action];
    [self presentViewController:alertvc animated:YES completion:nil];
    
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
