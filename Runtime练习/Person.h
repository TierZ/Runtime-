//
//  Person.h
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,copy)NSString * name;

-(void)sayHello;
-(void)sayName;
@end
