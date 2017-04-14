//
//  Animal.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/14.
//  Copyright © 2017年 --. All rights reserved.
//

#import "Animal.h"
#import <objc/runtime.h>
@implementation Animal
-(void)run{
    NSLog(@"动物在跑");
}





/**
 如果没有找到方法就会转向拦截调用。

 @param sel 被拦截的方法
 @return 。。
 */
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"调用了 不存在的方法");
    
    /*
     动态创建一个方法
     Class cls 给哪个类添加方法，本例中是self
     SEL name 添加的方法，本例中是重写的拦截调用传进来的selector。
     IMP imp 方法的实现，C方法的方法实现可以直接获得。如果是OC方法，可以用+ (IMP)instanceMethodForSelector:(SEL)aSelector;获得方法的实现。
     "v@:"方法的签名，
     */
    class_addMethod([self class], sel, (IMP)addMethod, "v:@");
        return YES;
}
+(BOOL)resolveClassMethod:(SEL)sel{
    return NO;
}

void addMethod(id self,SEL _cmd){
    
    NSLog(@"动态添加一个方法，");
    
}

@end
