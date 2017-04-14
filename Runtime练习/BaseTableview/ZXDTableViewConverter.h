//
//  ZXDTableViewConverter.h
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZXDBaseCell;

typedef id(^MethodParamsBlock)(NSArray*params);
@interface ZXDTableViewConverter : NSObject<UITableViewDelegate,UITableViewDataSource>
-(instancetype)initWithTableViewCarrier:(id)carrier dataSource:(NSMutableArray*)dataArray;
-(void)registTableWithMethod:(SEL)selector params:(MethodParamsBlock)block;
@end

@interface UITableView (ZXDIdCell)
-(ZXDBaseCell*)cellForIndexPath:(NSIndexPath*)indexPath cellClass:(Class)cellClass ;
@end
