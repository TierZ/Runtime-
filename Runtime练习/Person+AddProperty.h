//
//  Person+AddProperty.h
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/14.
//  Copyright © 2017年 --. All rights reserved.
//

#import "Person.h"
#import "Animal.h"
@interface Person (AddProperty)
@property (nonatomic,assign)int age;
@property (nonatomic,copy)NSString * gender;
@property (nonatomic,strong)Animal  * dog;
@end
