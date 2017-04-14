//
//  ZXDBaseCell.h
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXDBaseCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) id zxdCellData;
+(float)cellHeightWithCellData:(id)zxdCellData;
-(void)setCellData:(id)zxdCellData;
@end
