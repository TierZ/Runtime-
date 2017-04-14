//
//  UIImage+ZXD_Image.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "UIImage+ZXD_Image.h"
#import <objc/runtime.h>
@implementation UIImage (ZXD_Image)
+(void)load{
    Method method1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method method2 = class_getClassMethod([UIImage class], @selector(zxd_imageNamed:));
    method_exchangeImplementations(method1, method2);

}
+(UIImage*)zxd_imageNamed:(NSString*)name{
    NSLog(@"执行自己修改的方法");
    name = @"icon2.jpg";

    return [UIImage zxd_imageNamed:name];
}


@end
