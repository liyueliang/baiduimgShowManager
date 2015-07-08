//
//  YLWaterViewController.m
//  BaiduImgShow
//
//  Created by jlt on 15/6/30.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLWaterViewController.h"
#import "YLWaterFlowCell.h"
#import "YLWaterFlowView.h"
#import "UIImageView+WebCache.h"
#import "YLImageModel.h"
#import "MJRefresh.h"
#import "YLHttpTool.h"
#import "JSONKit.h"
#import "YLSettingViewController.h"
#import "MJPhotoBrowser.h"
#import "ASIHTTPRequest.h"
#import "AppDelegate.h" 
#import "MJPhoto.h"
#import "AFNetworking.h"

@interface YLWaterViewController()<YLWaterFlowViewDataSoure,YLWaterFlowViewDelegate>

@property(nonatomic,strong) NSMutableArray *soureData;
@property(nonatomic,weak) YLWaterFlowView *waterFlowView;
@property(nonatomic,assign) int currentIndex;
@end

@implementation YLWaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];  
    // Do any additional setup after loading the view.
 
    //添加瀑布流视图
    [self setupWaterFlowView];
    
    //请求网络
    [self setupNetWork];
   
}
 /**
 *  懒加载创建数据源对象
 *
 *  @return
 */
-(NSMutableArray *)soureData{
    if (_soureData==nil) {
        _soureData=[NSMutableArray array];
    }
    return _soureData;
}
#pragma mark - 网络加载
-(void)setupNetWork{
    __weak typeof(self) tempSelf =self;
    //添加上拉加载以及下拉加载
    [self.waterFlowView addLegendHeaderWithRefreshingBlock:^{
        
        [tempSelf setupData:@"down"];
        
    }];
    [self.waterFlowView addLegendFooterWithRefreshingBlock:^{
        [tempSelf setupData:@"up"];
        
    }];
    // 马上进入刷新状态
    [self.waterFlowView.legendHeader beginRefreshing];
    
}
-(void)refterDown{
    [self setupData:@"down"];
}
-(void)refterUp{
    [self setupData:@"up"];
}
-(void)setupData:(NSString *)commandName{
    
    if ([commandName isEqualToString:@"up"]) {//上拉加载
        self.currentIndex++;
    }else if([commandName isEqualToString:@"down"]){//下拉刷新
        self.currentIndex=0;
    }
    int trueIndex = self.currentIndex*60;
   
 
    
    //创建请求管理对象
    NSString *urlStr = [NSString stringWithFormat:apiImgUrl,[@"美女" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[NSString stringWithFormat:@"%d",trueIndex],@"60"];
     __weak typeof (self) tempSelf= self;
    
   
    
    
    [YLHttpTool getWithURL:urlStr params:nil success:^(id response){
        NSString *resultStr =response;
        if (resultStr!=nil&&![resultStr isEqualToString:@""]) {
            if ([commandName isEqualToString:@"up"]) {
                [tempSelf.soureData addObjectsFromArray:[tempSelf returnImgPicList:resultStr]];
            }else{
                [tempSelf.soureData removeAllObjects];
                [tempSelf.soureData addObjectsFromArray:[tempSelf returnImgPicList:resultStr]];
            }

        }
        
        [tempSelf.waterFlowView readLoad];
        [tempSelf.waterFlowView.legendHeader endRefreshing];
        [tempSelf.waterFlowView.legendFooter endRefreshing];
    }
     failure:^(NSError *error){
        [tempSelf.waterFlowView.legendFooter endRefreshing];
        [tempSelf.waterFlowView.header endRefreshing];
        
        int  tempCurrentIndex = tempSelf.currentIndex-1;
        tempSelf.currentIndex = tempCurrentIndex<=0?0:tempCurrentIndex;
    }];
    
    
}
-(NSArray *)returnImgPicList:(NSString  *)result{
    NSMutableArray *imgEntityList = [NSMutableArray array];
    NSDictionary *dict =[result objectFromJSONString];
    NSArray *imgList =[dict objectForKey:@"imgs"];
    for (NSDictionary *item in imgList) {
        if ([item objectForKey:@"id"]==nil) {
            continue;
        }
        YLImageModel *imgItem =[[YLImageModel alloc]init];
        imgItem.gid =[item objectForKey:@"id"];
        imgItem.desc =[item objectForKey:@"desc"];
        imgItem.fromPageTitle=[item objectForKey:@"fromPageTitle"];
        imgItem.column =[item objectForKey:@"column"];
        imgItem.date=[item objectForKey:@"date"];
        imgItem.downloadUrl =[item objectForKey:@"downloadUrl"];
        imgItem.imageUrl =[item objectForKey:@"imageUrl"];
        imgItem.imageWidth =[[item objectForKey:@"imageWidth"] intValue];
        imgItem.imageHeight =[[item objectForKey:@"imageHeight"] intValue];
        imgItem.thumbnailUrl =[item objectForKey:@"thumbnailUrl"];
        imgItem.thumbnailWidth=[[item objectForKey:@"thumbnailWidth"]intValue];
        imgItem.thumbnailHeight =[[item objectForKey:@"thumbnailHeight"] intValue];
        imgItem.thumbLargeWidth =[[item objectForKey:@"thumbLargeWidth"]intValue];
        imgItem.thumbLargeHeight =[[item objectForKey:@"thumbLargeHeight"] intValue];
        imgItem.thumbLargeUrl =[item objectForKey:@"thumbLargeUrl"];
        imgItem.thumbLargeTnWidth=[[item objectForKey:@"thumbLargeTnWidth"]intValue];
        imgItem.thumbLargeTnHeight=[[item objectForKey:@"thumbLargeTnHeight"]intValue];
        imgItem.thumbLargeTnUrl =[item objectForKey:@"thumbLargeTnUrl"];
        [imgEntityList addObject:imgItem];
    }
    return imgEntityList;
}
-(NSArray *)returnImgPicListOfDict:(NSDictionary  *)dict{
    NSMutableArray *imgEntityList = [NSMutableArray array];
    NSArray *imgList =[dict objectForKey:@"imgs"];
    for (NSDictionary *item in imgList) {
        if ([item objectForKey:@"id"]==nil) {
            continue;
        }
        YLImageModel *imgItem =[[YLImageModel alloc]init];
        imgItem.gid =[item objectForKey:@"id"];
        imgItem.desc =[item objectForKey:@"desc"];
        imgItem.fromPageTitle=[item objectForKey:@"fromPageTitle"];
        imgItem.column =[item objectForKey:@"column"];
        imgItem.date=[item objectForKey:@"date"];
        imgItem.downloadUrl =[item objectForKey:@"downloadUrl"];
        imgItem.imageUrl =[item objectForKey:@"imageUrl"];
        imgItem.imageWidth =[[item objectForKey:@"imageWidth"] intValue];
        imgItem.imageHeight =[[item objectForKey:@"imageHeight"] intValue];
        imgItem.thumbnailUrl =[item objectForKey:@"thumbnailUrl"];
        imgItem.thumbnailWidth=[[item objectForKey:@"thumbnailWidth"]intValue];
        imgItem.thumbnailHeight =[[item objectForKey:@"thumbnailHeight"] intValue];
        imgItem.thumbLargeWidth =[[item objectForKey:@"thumbLargeWidth"]intValue];
        imgItem.thumbLargeHeight =[[item objectForKey:@"thumbLargeHeight"] intValue];
        imgItem.thumbLargeUrl =[item objectForKey:@"thumbLargeUrl"];
        imgItem.thumbLargeTnWidth=[[item objectForKey:@"thumbLargeTnWidth"]intValue];
        imgItem.thumbLargeTnHeight=[[item objectForKey:@"thumbLargeTnHeight"]intValue];
        imgItem.thumbLargeTnUrl =[item objectForKey:@"thumbLargeTnUrl"];
        [imgEntityList addObject:imgItem];
    }
    return imgEntityList;
}
/**
 *  配置瀑布流视图
 */
-(void)setupWaterFlowView{
    YLWaterFlowView *waterFlowView =[[YLWaterFlowView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    waterFlowView.waterflowDataSoure=self;
    waterFlowView.waterflowDelegate =self;
    [self.view addSubview:waterFlowView];
    self.waterFlowView =waterFlowView;
}
#pragma mark -  waterflowview datasoure
-(NSUInteger)numberOfCellsInWaterFlowView:(YLWaterFlowView *)waterflowView{
    return self.soureData.count;
}
-(NSUInteger)numberOfColumnsInWaterflowView:(YLWaterFlowView *)waterflowView{
    return 3;
}
-(CGFloat)waterflowView:(YLWaterFlowView *)waterflowview marginForType:(YLWaterFlowViewMarginType)type{
 
    CGFloat margin=0;
    switch (type) {
        case WaterFlowViewMarginTop:
            margin=1;
            break;
        case WaterFlowViewMarginBottom:
            break;
        case WaterFlowViewMarginLeft:
            margin=1;
            break;
        case WaterFlowViewMarginRight:
            margin=1;
            break;
        case WaterFlowViewMarginColumn:
            
            break;
        case  WaterFlowViewMarginRow:
            margin=1;
            break;
        default:
            break;
    }
    return margin;

}
-(CGFloat)waterflowView:(YLWaterFlowView *)waterflowview heightAtIndex:(NSUInteger)index{
    CGFloat height=0;
    YLImageModel *imgEntity =[self.soureData objectAtIndex:index];
    //根据Cell的宽度和图片的宽高比 算出cell的高度
    height =waterflowview.cellWidth*imgEntity.thumbLargeHeight/imgEntity.thumbLargeWidth;
    return height;
}
-(YLWaterFlowCell *)waterflowView:(YLWaterFlowView *)waterflowview cellAtIndex:(NSUInteger)index{
    //创建cell
    YLWaterFlowCell *cell =[YLWaterFlowCell cellWithWaterFlowView:waterflowview];
    if (self.soureData==nil) {
        return cell;
    }
    //获取当前索引对应的模型对象
    YLImageModel *imgEntity = [self.soureData objectAtIndex:index];
    //设置当前cell对应的图片 
    [cell sd_setImageWithURL:[NSURL URLWithString:imgEntity.thumbLargeUrl]];
    return cell;
}
#pragma mark -waterflowview delegate
-(void)waterflowView:(YLWaterFlowView *)waterflowview didSelectAtIndex:(NSUInteger)index{
    YLWaterFlowCell *cell =[waterflowview waterViewCellForRowAtIndex:index];
    [self photoTap:cell withCurrentIndex:index];
}
#pragma mark -显示图片浏览
- (void)photoTap:(UIView *)waterView withCurrentIndex:(NSInteger)index
{
    
    NSUInteger count = self.soureData.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView =(UIImageView *)waterView; // 来源于哪个UIImageView
        
        YLImageModel *imgModel =[self.soureData objectAtIndex:i];
        NSString *photoUrl = imgModel.imageUrl;
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    YLLog(@"%@ lllllllll",self.title);

}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];

}
-(void)dealloc{
    if (self.waterFlowView) {
        self.waterFlowView.waterflowDataSoure=nil;
        self.waterFlowView.waterflowDelegate=nil;
        self.waterFlowView=nil;
    }
    YLLog(@"vc dealloc sdxxxxxxx");
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
