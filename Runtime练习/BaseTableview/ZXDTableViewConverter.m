//
//  ZXDTableViewConverter.m
//  Runtime练习
//
//  Created by 李清娟 on 2017/4/13.
//  Copyright © 2017年 --. All rights reserved.
//

#import "ZXDTableViewConverter.h"
#import "ZXDBaseCell.h"

@implementation UITableView (ZXDIdCell)

-(ZXDBaseCell*)cellForIndexPath:(NSIndexPath*)indexPath cellClass:(Class)cellClass {
    if ([cellClass isSubclassOfClass:[ZXDBaseCell class]]) {
         NSString *cellId = [NSString stringWithFormat:@"%@ID", NSStringFromClass(cellClass)];
        ZXDBaseCell * cell  = [self dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
           [self registerClass:cellClass forCellReuseIdentifier:cellId];
            cell = [self dequeueReusableCellWithIdentifier:cellId];
        }
        return cell;
    }
    return [ZXDBaseCell new];

}

@end


@interface ZXDTableViewConverter()
@property (nonatomic,strong)NSMutableDictionary * selectorsDic;
@property (nonatomic,strong)id tableCarrier;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation ZXDTableViewConverter
-(instancetype)initWithTableViewCarrier:(id)carrier dataSource:(NSMutableArray*)dataArray{
    self = [super init];
    if (self) {
        _tableCarrier = carrier;
        _dataArray = dataArray;
    }
    return self;
}

-(NSMutableDictionary *)selectorsDic{
    if (!_selectorsDic) {
        _selectorsDic = [NSMutableDictionary dictionary];
    }
    return _selectorsDic;
}

-(void)registTableWithMethod:(SEL)selector params:(MethodParamsBlock)block{
    [self.selectorsDic setObject:block forKey:NSStringFromSelector(selector)];
}

-(id)invocationWithSelector:(SEL)selector params:(NSArray*)params{
    NSMethodSignature * signature = [_tableCarrier methodSignatureForSelector:selector];
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = _tableCarrier;
    invocation.selector = selector;
    for (int i = 0; i<params.count; i++) {
        id param = params[i];

        [invocation setArgument:&param atIndex:i+2];
    }
    [invocation retainArguments];
    [invocation invoke];
    
    const char* returnType = signature.methodReturnType;
    id returnVaule;
    
    if (!strcmp(returnType, @encode(void))) {//无返回值
        returnVaule = nil;
    }
   else if (!strcmp(returnType, @encode(id))) {//返回值是对象
        [invocation getReturnValue:&returnVaule];
   }else{//返回值是基本数据类型
       NSInteger length = [signature methodReturnLength];
       void * buffer = (void*)malloc(length);
       [invocation getReturnValue:buffer];
       
       if (!strcmp(returnType, @encode(NSInteger))) {
           returnVaule = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
       }
      else if (!strcmp(returnType, @encode(BOOL))) {
           returnVaule = [NSNumber numberWithBool:*((BOOL*)buffer)];
      }else if (!strcmp(returnType, @encode(CGFloat))){
       returnVaule = [NSNumber numberWithBool:*((CGFloat*)buffer)];
      }
   }
    return returnVaule;
}

-(id)convertionWithFunc:(NSString*)func params:(NSArray*)params{
    SEL selector = NSSelectorFromString(func);
    if ([_tableCarrier respondsToSelector:selector]) {
        return [self invocationWithSelector:selector params:params];
    }else if([[self.selectorsDic allKeys]containsObject:func]){
        MethodParamsBlock block = [self.selectorsDic objectForKey:func];
        return block(params);
    }return nil;

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = [[self convertionWithFunc: NSStringFromSelector(_cmd) params:@[tableView]] integerValue];
    if (sections > 0) {
        return sections;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [[self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(section)]] integerValue];
    if (rows > 0) {
        return rows;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDBaseCell *backCell = [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, indexPath]];
    if (backCell) {
        return backCell;
    }
    return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(section)]];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(section)]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, indexPath]] boolValue];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, indexPath]] boolValue];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView]];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return [[self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, title, @(index)]] integerValue];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(editingStyle), indexPath]];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, sourceIndexPath, destinationIndexPath]];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat backHeight = [[self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, indexPath]] floatValue];
    if (backHeight > 0) {
        return backHeight;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [[self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(section)]] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [[self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(section)]] floatValue];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(section)]];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, @(section)]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, indexPath]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self convertionWithFunc:NSStringFromSelector(_cmd) params:@[tableView, indexPath]];
}

@end
