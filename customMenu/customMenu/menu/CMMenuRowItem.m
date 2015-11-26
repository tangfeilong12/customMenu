//
//  CMMenuRowItem.m
//  customMenu
//
//  Created by mac on 15/11/26.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMMenuRowItem.h"

@implementation CMMenuRowItem

+(instancetype)menuRowItemWithDic:(NSDictionary *)dic
{
    CMMenuRowItem *rowItem = [[CMMenuRowItem alloc] init];
    
    [rowItem setValuesForKeysWithDictionary:dic];
    
    return rowItem;
}
@end
