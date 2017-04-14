//
//  ZXDBaseCellModel.h
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXDBaseCellModel : NSObject
@property (nonatomic,strong)id cellData;
@property (nonatomic,strong)Class cellClass;
@property (nonatomic,weak)id cellDelegate;
@property (nonatomic,assign)float cellHeight;
+(instancetype)modelWithCellClass:(Class)cellClass cellHeight:(float)cellHeight cellData:(id)cellData;

-(instancetype)initWithCellClass:(Class)cellClass cellHeight:(float)cellHeight cellData:(id)cellData;
@end
