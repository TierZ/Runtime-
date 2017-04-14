//
//  Person+AddProperty.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/14.
//  Copyright © 2017年 --. All rights reserved.
//

#import "Person+AddProperty.h"
#import <objc/runtime.h>

@implementation Person (AddProperty)
static char *ageKey = "a";
static char *genderKey = "g";
static char * animalKey = "animal";

/*
 OBJC_ASSOCIATION_ASSIGN;            //assign策略
 OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
 OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
 
 OBJC_ASSOCIATION_RETAIN;
 OBJC_ASSOCIATION_COPY;
 */
/*
 * id object 给哪个对象的属性赋值
 const void *key 属性对应的key
 id value  设置属性值为value
 objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
 */

-(int)age{

    return [objc_getAssociatedObject(self, &ageKey) intValue];
}

-(void)setAge:(int)age{
    NSString * ageStr = [NSString stringWithFormat:@"%d",age];
    objc_setAssociatedObject(self, &ageKey, ageStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)gender{
    return objc_getAssociatedObject(self, &genderKey);
}

-(void)setGender:(NSString *)gender{
    objc_setAssociatedObject(self, &genderKey, gender, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@是个%@孩今年%d岁了 ", self.name, self.gender, self.age];
}

-(Animal *)dog{
    return objc_getAssociatedObject(self, &animalKey);
}

-(void)setDog:(Animal *)dog{
    objc_setAssociatedObject(self, &animalKey, dog, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
