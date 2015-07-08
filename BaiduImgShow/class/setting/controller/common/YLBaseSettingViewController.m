//
//  YLBaseSettingViewController.m
//  BaiduImgShow
//
//  Created by jlt on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLBaseSettingViewController.h"
#import "YLSettingSwitchItem.h"
#import "YLSettingLabelItem.h"
#import "YLSettingArrowItem.h"
#import "YLSettingGroup.h"
#import "YLSettingCell.h"
@interface YLBaseSettingViewController ()

@end

@implementation YLBaseSettingViewController
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self =[super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.tableView.backgroundView=nil;
    self.tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.tableView=nil;
}
-(NSMutableArray *)groupData{
    if (_groupData==nil) {
        _groupData=[NSMutableArray array];
   }
    return _groupData;
}
#pragma mark - table datasoure
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YLSettingGroup *subArray =[self.groupData objectAtIndex:section];
    return subArray.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    YLSettingCell *cell =[YLSettingCell cellWithTableView:tableView];
    //取出当前组
    YLSettingGroup *subArray = [self.groupData objectAtIndex:indexPath.section];
    //取出当前item
    YLSettingItem *item = [subArray.items objectAtIndex:indexPath.row];
    cell.item =item;
    
    cell.lastRowInSection = subArray.items.count==indexPath.row+1;//当前组对应的最后一行
    return cell;
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YLSettingGroup *group =[self.groupData objectAtIndex:section];
    return group.header;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    YLSettingGroup *group =[self.groupData objectAtIndex:section];
    return group.footer;
}
#pragma mark -table delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView cellForRowAtIndexPath:indexPath];
    YLSettingGroup *group=[self.groupData objectAtIndex:indexPath.section];
    YLSettingItem *item =[group.items objectAtIndex:indexPath.row];
    if (item.option) {
        item.option();
    }else if([item isKindOfClass:[YLSettingArrowItem class]]){//箭头 跳转
        YLSettingArrowItem *arrowItem =(YLSettingArrowItem *)item;
        if (arrowItem.destVcClass==nil)return;
        //创建控制器 跳转
        [self.navigationController pushViewController:[[arrowItem.destVcClass alloc]init] animated:YES];
    }
}

-(void)dealloc{
    YLLog(@"%@ base dealloc",NSStringFromClass([self class]));
}
@end
