//
//  YLBaiDuImgViewController.m
//  BaiduImgShow
//  
//  Created by jlt on 15/6/18.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLBaiDuImgViewController.h"
#import "MJPhoto.h"
#import "MobClick.h"
#import "YLSectionView.h"
#import "YLSettingViewController.h"
#import "YLWaterViewController.h" 

@interface YLBaiDuImgViewController ()<YLSectionViewDelegte>
{
    GDTMobBannerView *_bannerView;//声明一个GDTMobBannerView的实例
}
@property(nonatomic,weak) YLSectionView *sectionView;
@end

@implementation YLBaiDuImgViewController

-(void)viewWillAppear:(BOOL)animated{
   
    //友盟统计页面展示
    [MobClick beginLogPageView:@"YLBaiduImgShow"]; 
     [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟统计页面展示
    [MobClick endLogPageView:@"YLBaiduImgShow"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IOS7) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.title=@"美图鉴赏";
    //配置banner广告视图
    [self setupBannerView];
    
    //配置右边按钮
    [self makeConfigBarButtonItem];

    //添加类别视图
    [self setupTypeView];
    
 
    
}
///**
// *  根据设置->根据广告开关管理来是否显示广告
// */
//-(void)updateBannerView{
//    NSUserDefaults *userDefautls =[NSUserDefaults standardUserDefaults];
//    if ([userDefautls objectForKey:@"ad_manager"]) {
//        BOOL gd_truenOn =[[userDefautls objectForKey:@"ad_manager"] boolValue];
//        if (gd_truenOn==NO) {
//                _bannerView.frame=CGRectMake(0, 0, self.view.frame.size.width, 0);
//                self.sectionView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//            [self.view setNeedsDisplay];
//        }
//    }
//}
/**
 *  配置banner广告视图
 */
-(void)setupBannerView{
    
//    NSUserDefaults *userDefautls =[NSUserDefaults standardUserDefaults];
//    if ([userDefautls objectForKey:@"ad_manager"]) {
//        BOOL gd_truenOn =[[userDefautls objectForKey:@"ad_manager"] boolValue];
//        if (gd_truenOn==NO) {
//            return;
//        }
//    }
    [self createBannerView];

}
/*
 * 创建Banner广告View
 * "appkey" 指在 http://e.qq.com/dev/ 能看到的app唯一字符串
 * "placementId" 指在 http://e.qq.com/dev/ 生成的数字串，广告位id
 *
 * banner条广告，广点通提供如下3中尺寸供开发者使用
 * 320*50 适用于iPhone
 * 468*60、728*90适用于iPad
 * banner条的宽度开发者可以进行手动设置，用以满足开发场景需求或是适配最新版本的iphone
 * banner条的高度广点通侧强烈建议开发者采用推荐的高度，否则显示效果会有影响
 *
 * 这里以320*50为例
 */

-(void)createBannerView{
 
      _bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     GDTMOB_AD_SUGGEST_SIZE_320x50.width,
                                                                     GDTMOB_AD_SUGGEST_SIZE_320x50.height)
                                                   appkey:@"1104670845"
                                              placementId:@"2090702427456028"];
    
    _bannerView.delegate = self; // 设置Delegate
    _bannerView.currentViewController = self; //设置当前的ViewController
    _bannerView.interval = 5; //【可选】设置刷新频率;默认30秒
    _bannerView.isGpsOn = NO; //【可选】开启GPS定位;默认关闭
    _bannerView.showCloseBtn = YES; //【可选】展示关闭按钮;默认显示
    _bannerView.isAnimationOn = YES; //【可选】开启banner轮播和展现时的动画效果;默认开启
    [self.view addSubview:_bannerView]; //添加到当前的view中
    [_bannerView loadAdAndShow]; //加载广告并展示
}
/**
 *  添加设置按钮
 */
-(void)makeConfigBarButtonItem{
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(makeClick:)];
    self.navigationItem.rightBarButtonItem =rightBarButton;
}
/**
 *  设置按钮处理函数
 *
 *  @param obj <#obj description#>
 */
-(void)makeClick:(id)obj{
        YLSettingViewController *settingVC =[[YLSettingViewController alloc]init];
        [self.navigationController pushViewController:settingVC animated:YES];
}
/**
 *  添加类别视图
 */
-(void)setupTypeView{
     
    YLSectionView *sectionView =[[YLSectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    sectionView.sectionDelegate=self;
    [self.view addSubview:sectionView];
    self.sectionView = sectionView;
    //初始化栏目
    NSArray *itemArray =[NSArray arrayWithObjects:@"全部",@"小清新",@"嫩萝莉",@"唯美",@"清纯",@"气质",@"校花",@"可爱",@"非主流", nil];
 
    //设置栏目对应的view
    NSMutableArray *itemViewArray =[NSMutableArray array];
    for (int i=0; i<itemArray.count; i++) {
        YLWaterViewController *weaterVC =[[YLWaterViewController alloc]init];
        weaterVC.title=[itemArray objectAtIndex:i];
        [itemViewArray addObject:weaterVC];
    }
    sectionView.subViewControllers=itemViewArray;
    
    
}
#pragma mark -内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    YLLog(@"%@ ddsdfsdfasdf",self.title);
    
}
#pragma mark - sectionDelegate
-(void)sectionView:(YLSectionView *)sectionView didSelectedSectionItem:(NSString *)itemTitle{
    
}
#pragma mark -bannerview delegate
// 请求广告条数据成功后调用
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)bannerViewDidReceived
{
    YLLog(@"%s",__FUNCTION__);
    self.sectionView.frame=CGRectMake(0, GDTMOB_AD_SUGGEST_SIZE_320x50.height, self.view.frame.size.width, self.view.frame.size.height-GDTMOB_AD_SUGGEST_SIZE_320x50.height);
}

// 请求广告条数据失败后调用
//
// 详解:当接收服务器返回的广告数据失败后调用该函数
- (void)bannerViewFailToReceived:(NSError *)error
{
    YLLog(@"%s, Error:%@",__FUNCTION__,error);
    
}

// 应用进入后台时调用
//
// 详解:当点击下载或者地图类型广告时，会调用系统程序打开，
// 应用将被自动切换到后台
- (void)bannerViewWillLeaveApplication
{
    YLLog(@"%s",__FUNCTION__);
}

// banner条曝光回调
//
// 详解:banner条曝光时回调该方法
- (void)bannerViewWillExposure
{
    YLLog(@"%s",__FUNCTION__);
}

// banner条点击回调
//
// 详解:banner条被点击时回调该方法
- (void)bannerViewClicked
{
    YLLog(@"%s",__FUNCTION__);
}

/**
 *  banner条被用户关闭时调用
 *  详解:当打开showCloseBtn开关时，用户有可能点击关闭按钮从而把广告条关闭
 */
- (void)bannerViewWillClose
{
    YLLog(@"%s",__FUNCTION__);
    self.sectionView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
@end
