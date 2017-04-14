//
//  RuntimeListCell.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "RuntimeListCell.h"

@implementation RuntimeListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor redColor];
    }
    return self;
}

- (void)setCellData:(NSString *)zxdCellData{
    self.zxdCellData = zxdCellData;
    self.textLabel.text = zxdCellData;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = [RuntimeListCell cellHeightWithCellData:self.zxdCellData];
    self.textLabel.frame =  CGRectMake(10, 10, self.frame.size.width - 20, height - 20);
}
+(float)cellHeightWithCellData:(NSString*)zxdCellData{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGRect rect = [zxdCellData boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 999)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:dic
                                         context:nil];
    return 20 + rect.size.height;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
