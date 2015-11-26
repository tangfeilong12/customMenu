//
//  CMMenuRowItem.h
//  customMenu
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMenuRowItem : NSObject
@property(nonatomic, strong) NSString *iconName;
@property(nonatomic, strong) NSString *addrName;

@property(nonatomic, copy) void(^block)();
+(instancetype)menuRowItemWithDic:(NSDictionary *)dic;
@end
