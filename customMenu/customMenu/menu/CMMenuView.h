//
//  CMMenuView.h
//  customMenu
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMMenuView;
@protocol CMMenuViewDelegate <NSObject>

@optional
-(void)CMMenuView:(CMMenuView *)menuView fromIndex:(NSInteger)from toIndex:(NSInteger)to;


@end
@interface CMMenuView : UIView

@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, assign) id<CMMenuViewDelegate> delegate;
/**
 *  显示一个自定义菜单栏
 *
 *  @param indexFrame
 *  @param view
 *
 *  @return
 */
+(instancetype)showMenuViewWith:(CGRect) indexFrame toView:(UIView *) view;
/**
 *  销毁一个自定义菜单栏
 */
+(void)dismissCrrentMenu;
@end
