//
//  YLSettingCellTableViewCell.h
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSettingItem.h"
@interface YLSettingCell : UITableViewCell
@property(nonatomic,assign,getter=isLastRowInSection) BOOL lastRowInSection;
@property(nonatomic,strong) YLSettingItem *item;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
