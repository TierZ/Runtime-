//
//  Animal.h
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/14.
//  Copyright © 2017年 --. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject
@property (nonatomic,copy)NSString * kinds;
@property (nonatomic,copy)NSString * name;
-(void)run;
@end
