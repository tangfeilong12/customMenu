//
//  ViewController.m
//  customMenu
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CMMenuView.h"
@interface ViewController ()<CMMenuViewDelegate>
@property(nonatomic, strong) NSMutableArray * dataArray;
@property(nonatomic, assign) CGRect menuRect;
@property(nonatomic, weak) UIView *menuView;
@end

@implementation ViewController
/**
 *  懒加载数据存放数组
 *
 *  @return <#return value description#>
 */
-(NSArray *)dataArray
{

    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }

    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.先设置导行栏基本设置
    UIImage *image = [UIImage imageNamed:@"schoolListItem"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick:)];
    
    //2.这个属性用来设置整个导行栏的背景颜色，不是用很复杂的图片，单用纯色来做背景的话还是很好用
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    //3.设置导行栏不用透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    //4.添加我们的自定义菜单栏

    //4.1 告诉显示的数据
    NSDictionary * dic1 = @{
                            @"iconName":@"item_school",
                            @"addrName" : @"附近学校"
                           };
    
    NSDictionary * dic2 = @{
                            @"iconName":@"item_battle",
                            @"addrName" : @"联赛流程"
                            };
    NSDictionary * dic3 = @{
                            @"iconName":@"item_list",
                            @"addrName" : @"其他联赛"
                            };
    NSDictionary * dic4 = @{
                            @"iconName":@"item_chat",
                            @"addrName" : @"校内群聊"
                            };
    
    NSDictionary * dic5 = @{
                            @"iconName":@"item_share",
                            @"addrName" : @"邀请好友"
                            };
    
    [self.dataArray addObjectsFromArray:@[dic1,dic2,dic3,dic4,dic5]];
    
    //4.2 告诉显示的位置
    CGFloat menuLeftX = 10;
    CGFloat menuTopY = 10;
    CGFloat menuW = 125;
    CGFloat menuH = self.dataArray.count * 44;
    CGRect menuRect = CGRectMake(menuLeftX, menuTopY, menuW, menuH);
    self.menuRect = menuRect;

}

-(void)leftBtnClick:(UIButton *)btn
{
    
    NSLog(@"leftClick");
    if (self.menuView == nil) {
        //显示自定义菜单
        CMMenuView * menuView = [CMMenuView showMenuViewWith:self.menuRect toView:self.view];
        menuView.delegate = self;
        menuView.dataArray = self.dataArray;
        self.menuView = menuView;
    }else{
        //取消自定义菜单
        [CMMenuView dismissCrrentMenu];
        self.menuView = nil;
    }
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CMMenuViewDelegate代理方法
-(void)CMMenuView:(CMMenuView *)menuView fromIndex:(NSInteger)from toIndex:(NSInteger)to
{


    NSLog(@"%zd === %zd",from,to);

}

@end
