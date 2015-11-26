//
//  CMMenuView.m
//  customMenu
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#define tableViewW
#define tableViewH
#define CMEdegeInsetsMake UIEdgeInsetsMake(0, 10, 0, 10)
#import "CMMenuView.h"
#import "CMMenuRowItem.h"
@interface CMMenuView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *rowItemArray;
@property(nonatomic, weak) UITableView *tableV;
@property(nonatomic, assign)NSIndexPath *preIndexPath;
//@property(nonatomic, weak) CMMenuView *curretnMenuView;
@end
@implementation CMMenuView
static CMMenuView *_currentMenu;
/**
 *  用于存放模型数组
 *
 *  @return
 */
-(NSMutableArray *)rowItemArray
{

    if (_rowItemArray == nil) {
        
        _rowItemArray = [NSMutableArray array];
    }

    return _rowItemArray;
}

+(instancetype)showMenuViewWith:(CGRect)indexFrame toView:(UIView *)view
{
    //1.创建自定义menu,并且放入view的子控件中
    CMMenuView *menuView = [[CMMenuView alloc] init];
    menuView.frame = view.bounds;
    menuView.backgroundColor = [UIColor yellowColor];
    [view addSubview:menuView];
    
    _currentMenu = menuView;
    
    //2.创建meniview中的子控件，tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:indexFrame style:UITableViewStylePlain];
    //2.1 tableivew的一些相关设置
    tableView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
    tableView.separatorColor = [UIColor colorWithWhite:0.2 alpha:1];
    tableView.bounces = NO;
    tableView.layer.cornerRadius = 2;
    //2.2 tableview的数据源和代理设置
    tableView.delegate = menuView;
    tableView.dataSource = menuView;
    [menuView addSubview:tableView];
    menuView.tableV = tableView;
    
    //3.设置tableview系统自带的分隔线的位置
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [tableView setSeparatorInset:CMEdegeInsetsMake];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [tableView setLayoutMargins:CMEdegeInsetsMake];
    }
    
    return menuView;
}

-(void)setDataArray:(NSArray *)dataArray
{

    _dataArray = dataArray;
    
    NSInteger count = dataArray.count;
    
    for (int i = 0; i< count; i++) {
        
        CMMenuRowItem *item = [CMMenuRowItem menuRowItemWithDic:dataArray[i]];
        
        [self.rowItemArray addObject:item];
    }
    
    //重新刷新
    [self.tableV reloadData];

}
/**
 *  取消menu
 */
-(void)dismiss
{
    
    //
    [UIView animateWithDuration:1 animations:^{
        
        self.alpha = 0;
        CGRect rect = self.tableV.frame;
        rect.size.width = 0;
        rect.size.height = 0;
        self.tableV.frame = rect;
    } completion:^(BOOL finished) {
        
        //彻底从父控件移除自己
        [self removeFromSuperview];
        _currentMenu = nil;
        
    }];
    
    
}
/**
 *  销毁当前的menu菜单
 */
+(void)dismissCrrentMenu
{
    
    if (!_currentMenu) return;
    
    [_currentMenu dismiss];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //1.销毁tableView
    [self dismiss];
    
}


#pragma mark - uitableview代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.rowItemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString * ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //cell的相关设置
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
    //传值模型给每个cell
    CMMenuRowItem *rowItem = self.rowItemArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:rowItem.iconName];
    cell.textLabel.font =[UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = rowItem.addrName;
    return cell;
}

//这里同样是为了设置cell系统自带的分隔线的位置
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:CMEdegeInsetsMake];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:CMEdegeInsetsMake];
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"tangfeilong");
    
    if ([self.delegate respondsToSelector:@selector(CMMenuView:fromIndex:toIndex:)]) {
        
        [self.delegate CMMenuView:self fromIndex:self.preIndexPath.row toIndex:indexPath.row];
    }
    
    self.preIndexPath = indexPath;
}
-(void)drawRect:(CGRect)rect
{

    [super drawRect:rect];
    //1.先计算出我们要画的三角形的三个点
    CGRect rectV = self.tableV.frame;
    
    CGPoint beganP = CGPointMake(5+rectV.origin.x, rectV.origin.y);
    CGPoint endP = CGPointMake(15+rectV.origin.x, rectV.origin.y);
    CGPoint centerP = CGPointMake(10+rectV.origin.x, -8+rectV.origin.y);
    
    //2.获得上下文，给出三角莆
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, beganP.x, beganP.y);
    CGContextAddLineToPoint(context, centerP.x, centerP.y);
    CGContextAddLineToPoint(context, endP.x, endP.y);
    CGContextClosePath(context);
    
    [[UIColor grayColor] set];
    CGContextFillPath(context);
    
}

@end
