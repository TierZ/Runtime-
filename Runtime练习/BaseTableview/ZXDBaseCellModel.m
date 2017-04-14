//
//  ZXDBaseCellModel.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "ZXDBaseCellModel.h"

@implementation ZXDBaseCellModel
+(instancetype)modelWithCellClass:(Class)cellClass cellHeight:(float)cellHeight cellData:(id)cellData{
    ZXDBaseCellModel * model = [ZXDBaseCellModel new];
    model.cellClass = cellClass;
    model.cellData = cellData;
    model.cellHeight = cellHeight;
    return model;

}

-(instancetype)initWithCellClass:(Class)cellClass cellHeight:(float)cellHeight cellData:(id)cellData{
    return [ZXDBaseCellModel modelWithCellClass:cellClass cellHeight:cellHeight cellData:cellData];
}
@end
