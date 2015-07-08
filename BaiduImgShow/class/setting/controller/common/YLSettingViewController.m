//
//  YLSettingViewController.m
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLSettingViewController.h"
#import "YLSettingArrowItem.h"
#import "YLSettingSwitchItem.h"
#import "YLSettingLabelItem.h"
#import "YLSettingArrowItem.h"
#import "YLSettingGroup.h" 
#import "MBProgressHUD+MJ.h"
#import "YLAppInfoViewController.h"
#import "YLAboutViewController.h"
#import "YLMoneyViewController.h"
#import "YLSDWebImgCacheTool.h"
#import "YLVersionTool.h"
#import "MobClick.h"
@interface YLSettingViewController ()<UIAlertViewDelegate>
@property(nonatomic,copy) NSString *versionUrl;
@end

@implementation YLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title=@"设置";
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick:)];    //0组
    self.navigationItem.leftBarButtonItem =leftBarItem;
    [self setupConfig];
  


}
-(void)setupConfig{
    [self.groupData removeAllObjects];
    //程序说明
    YLSettingItem *appItem =[YLSettingArrowItem itemWithTitle:@"免责声明" destVcClass:[YLAppInfoViewController class]];
    //联系我们
    YLSettingItem *aboutItem =[YLSettingArrowItem itemWithTitle:@"关于我们" destVcClass:[YLAboutViewController class]];
    //意见反馈
    //YLSettingItem *msgItem =[YLSettingArrowItem itemWithTitle:@"意见反馈"];
    //捐赠
    YLSettingItem *moneyItem =[YLSettingArrowItem itemWithTitle:@"捐赠我们" destVcClass:[YLMoneyViewController class]];
     YLSettingGroup *group0 =[[YLSettingGroup alloc]init];
    group0.items=[NSArray arrayWithObjects:appItem,aboutItem,moneyItem, nil];
   
   
    //广告管理
//    YLSettingItem *adSetting =[YLSettingSwitchItem itemWithTitle:@"广告管理"];
//    adSetting.key=@"ad_manager";
    //检测版本
    YLSettingItem *checkVersionItem =[YLSettingArrowItem itemWithTitle:@"检测新版本"];
    checkVersionItem.subTitle=[YLVersionTool versionSize];
    checkVersionItem.option=^{
        //检测新版本
        [MobClick checkUpdateWithDelegate:self selector:@selector(callBackSelectorWithDictionary:)];
    };
    //缓存管理
    YLSettingItem *cacheItem =[YLSettingItem itemWithTitle:@"缓存清理"];
    [cacheItem setSubTitle:@"0.00M"];
    
    //防止block 循环引用
    __weak YLSettingItem *tempCacheItem = cacheItem;
    __weak typeof (self) tempSelf =self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        float fileSize =[YLSDWebImgCacheTool cacheSize];
        dispatch_async(dispatch_get_main_queue(), ^{
             [tempCacheItem setSubTitle:[NSString stringWithFormat:@"%.2fM",fileSize]];
            [self.tableView reloadData];
        });
    });
   
    cacheItem.option=^{
        [YLSDWebImgCacheTool clearCache];
        [tempCacheItem setSubTitle:@"0.00M"];
        [tempSelf.tableView reloadData];
    };
    YLSettingGroup *group1 =[[YLSettingGroup alloc]init];
    group1.items=[NSArray arrayWithObjects:checkVersionItem,cacheItem, nil];
    
    [self.groupData addObject:group0];
    [self.groupData addObject:group1];
}
-(void)callBackSelectorWithDictionary:(NSDictionary *)dict{
    if ([[dict objectForKey:@"update"] boolValue]==NO) {
        [MBProgressHUD showSuccess:@"您当前已是最新版本"];
    }else{
        NSString *urlPaht =[dict objectForKey:@"path"];
        self.versionUrl =urlPaht;
        UIAlertView *alterMSG =[[UIAlertView alloc]initWithTitle:@"系统提示" message:[dict objectForKey:@"update_log"] delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"确定", nil];
        [alterMSG show];
    }
}
-(void)backItemClick:(id)obj{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//忽略

    }else if(buttonIndex==1){//下载
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.versionUrl]];
    }
}
 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    YLLog(@"ooooooooxxxxsetting dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
