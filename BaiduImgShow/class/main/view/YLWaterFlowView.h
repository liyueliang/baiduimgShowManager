//
//  WaterFlowView.h
//  BaiduImgShow
//  
//  Created by jlt on 15/6/18.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLWaterFlowView;
@class  YLWaterFlowCell;

#define YLWaterFlowViewScreenWidth [UIScreen mainScreen].bounds.size.width
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

typedef enum{
    WaterFlowViewMarginTop,
    WaterFlowViewMarginBottom,
    WaterFlowViewMarginLeft,
    WaterFlowViewMarginRight,
    WaterFlowViewMarginColumn,
    WaterFlowViewMarginRow
}YLWaterFlowViewMarginType;


/**
 *  waterflow对应的数据源
 */
@protocol YLWaterFlowViewDataSoure<NSObject>
@required
/**
 一共有多少条数据
 */
-(NSUInteger)numberOfCellsInWaterFlowView:(YLWaterFlowView *)waterflowView;
/**
 返回index位置对应的cell
 */
-(YLWaterFlowCell *)waterflowView:(YLWaterFlowView *)waterflowview cellAtIndex:(NSUInteger)index;
@optional
/**
 一共有多少列
 */
-(NSUInteger)numberOfColumnsInWaterflowView:(YLWaterFlowView *)waterflowView;
@end









@protocol YLWaterFlowViewDelegate <NSObject>
@optional
/*
 第index位置cell对应的高度
 */
-(CGFloat)waterflowView:(YLWaterFlowView *)waterflowview heightAtIndex:(NSUInteger)index;
/*
 选中第index位置的cell
 */
-(void)waterflowView:(YLWaterFlowView *)waterflowview didSelectAtIndex:(NSUInteger)index;
/*
 返回间距
 */
-(CGFloat)waterflowView:(YLWaterFlowView *)waterflowview marginForType:(YLWaterFlowViewMarginType)type;

@end








/**
 *  waterflow 视图
 */
@interface YLWaterFlowView : UIScrollView
@property(nonatomic,assign) id<YLWaterFlowViewDataSoure> waterflowDataSoure;
@property(nonatomic,assign) id<YLWaterFlowViewDelegate> waterflowDelegate;
-(void)readLoad;//刷新数据
-(CGFloat)cellWidth;//cell 宽度
/*
 根据标识去缓存池中查找 可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
/**
 *  根据path获取对应的waterflowview
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
-(YLWaterFlowCell *)waterViewCellForRowAtIndex:(NSUInteger *)index;
@end

 