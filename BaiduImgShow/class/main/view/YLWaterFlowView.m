//
//  WaterFlowView.m
//  BaiduImgShow
//
//  Created by jlt on 15/6/18.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLWaterFlowView.h"
#import "YLWaterFlowCell.h"
#define  WaterflowViewDefaultNumberOfClunms 3 //默认列数
#define WaterflowViewDefaultCellHegint 100  //默认高度
#define WaterflowViewDefaultMargin 5  //默认间距

@interface YLWaterFlowView()
 @property(nonatomic,strong) NSMutableArray *cellFrams;//存放所有的frame
@property(nonatomic,strong) NSMutableDictionary *displayIngCells;//可视cells
@property(nonatomic,strong) NSMutableSet *resuableCells;//cells缓存池
@end
@implementation YLWaterFlowView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        NSLog(@"%@",NSStringFromCGRect(frame));
    }
    return self;
}
-(NSMutableSet *)resuableCells{
    if (_resuableCells==nil) {
        _resuableCells =[NSMutableSet set];
        
    }
    return _resuableCells;
}
-(NSMutableDictionary *)displayIngCells{
    if (_displayIngCells==nil) {
        _displayIngCells=[NSMutableDictionary dictionary];
    }
    return _displayIngCells;
}
-(NSMutableArray *)cellFrams{
    if (_cellFrams==nil) {
        _cellFrams=[NSMutableArray array];
    }
    return _cellFrams;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //遍历所有的cellframe
    NSArray *tempCellFrams = self.cellFrams;
    NSMutableDictionary *tempDisplayIngCells =self.displayIngCells;
    for (int i=0; i<tempCellFrams.count; i++) {
        //取出当前索引对应的cellframe
        CGRect currentRect = [[tempCellFrams objectAtIndex:i]CGRectValue];
        //取出当前索引对应的cell
        YLWaterFlowCell *cell =[tempDisplayIngCells objectForKey:[NSString stringWithFormat:@"%d",i]];
 
        //判断cellframe是否在当前可见区域
        if ([self isInScreen:currentRect]) {//在可见区域 添加到view上
            if (cell==nil) {//当前对应的cell不存在 则创建 以防重复创建cell
                cell =[self.waterflowDataSoure waterflowView:self cellAtIndex:i];
                cell.frame = currentRect;
                //cell.backgroundColor=RandomColor; 设置背景色 调试
                [self addSubview:cell];
                 
                //添加到可视cells数组中
                [tempDisplayIngCells setObject:cell
                                         forKey:[NSString stringWithFormat:@"%d",i]];
            }
           
        }else{ //不在可见区域
            if (cell) {//cell 有可见区域移动到不可见区域
                [cell removeFromSuperview];
                [tempDisplayIngCells removeObjectForKey:[NSString stringWithFormat:@"%d",i]];
                
                //把当前不可见的cell 存放到缓存池中
                [self.resuableCells addObject:cell];
            }
        }
    }
    self.displayIngCells =tempDisplayIngCells;
}

-(void)readLoad{
    //每次加载数据 清空缓存
    [self.displayIngCells removeAllObjects];
    [self.cellFrams removeAllObjects];
    [self.resuableCells removeAllObjects];
    
    
    //一共有多少条数据
    NSUInteger numCount =[self.waterflowDataSoure numberOfCellsInWaterFlowView:self];
    //一共有几列
    NSUInteger numColsCount =[self numberOfColumns];
    //获取每个每个间距的值
    CGFloat marginLeft=[self  marginForType:WaterFlowViewMarginLeft];
    CGFloat marginRight =[self marginForType:WaterFlowViewMarginRight];
    CGFloat marginTop =[self  marginForType:WaterFlowViewMarginTop];
    CGFloat marginBootm =[self  marginForType:WaterFlowViewMarginBottom];
    CGFloat marginRow =[self marginForType:WaterFlowViewMarginRow];
    CGFloat marginCols=[self marginForType:WaterFlowViewMarginColumn];
    //根据列数计算出每个cell的宽度
    //(屏幕宽度-左边间距-右边间距-(列数-1)*列间距)/列数
    CGFloat cellW = [self cellWidth];
    //cell高度
    CGFloat cellH=0;//通过随机数实现
    //初始化一个数组 存放每列对应的最大y值
    CGFloat maxYOfColums[numColsCount];
    for (int i=0; i<numColsCount; i++) {
        maxYOfColums[i]=0.0;
    }
    //遍历总数据
    for (int i=0; i<numCount; i++) {
        //取出每个cell的高度
        cellH = [self heightAtIndex:i];
        int cellOfAtIndex=0;
        //取出第一个下标对应的值
        CGFloat maxYOfColsItem = maxYOfColums[cellOfAtIndex];
        //计算cellofatindex对应的y值
        for (int j=0; j<numColsCount; j++) {
            if (maxYOfColums[j]<maxYOfColsItem) {
                cellOfAtIndex = j;
                maxYOfColsItem=maxYOfColums[j];
            }
        }
        //每个cell的x(左边间距+cellOfAtIndex*(cellw+cellCol))
        CGFloat cellX=marginLeft+cellOfAtIndex*(cellW+marginCols);
        CGFloat cellY=0;
        
        if (maxYOfColsItem==0.0) {//首行
            cellY=marginTop;//top
        }else{
            cellY =maxYOfColsItem+marginRow;
        }
        
        //优化cell添加  使用缓冲池
        CGRect cellFrame =CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrams addObject:[NSValue valueWithCGRect:cellFrame]];
//        UIButton  *cell =[[UIButton alloc]initWithFrame:CGRectMake(cellX, cellY, cellW, cellH)];
//        cell.backgroundColor=RandomColor; 
//        [cell setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
//        [self addSubview:cell];
        
        

        maxYOfColums[cellOfAtIndex] = CGRectGetMaxY(cellFrame);
        
    }
    
    //设置contentSize
    CGFloat contentH=maxYOfColums[0];
    for (int i=0; i<numColsCount; i++) {
        if (maxYOfColums[i]>contentH) {
            contentH=maxYOfColums[i];
        }
    }
    contentH =contentH+marginBootm;
    self.contentSize=CGSizeMake(YLWaterFlowViewScreenWidth, contentH);
    
    //重新布局
    [self setNeedsLayout];
    
}

-(BOOL)isInScreen:(CGRect)frame{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) && (CGRectGetMinY(frame) < self.contentOffset.y + self.frame.size.height);
}
-(CGFloat)marginForType:(YLWaterFlowViewMarginType)type
{
    if ([self.waterflowDelegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.waterflowDelegate waterflowView:self marginForType:type];
    }else{
        return  WaterflowViewDefaultMargin;
    }
}
-(NSUInteger)numberOfColumns{
    if ([self.waterflowDataSoure respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.waterflowDataSoure numberOfColumnsInWaterflowView:self];
    }else
    {
        return WaterflowViewDefaultNumberOfClunms;
    }
}
-(CGFloat)heightAtIndex:(NSUInteger)index{
    if ([self.waterflowDelegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.waterflowDelegate waterflowView:self heightAtIndex:index];
    }else{
        return WaterflowViewDefaultCellHegint;
    }
}
/**
 cell 高度
 */
-(CGFloat)cellWidth{
    //cell的列数
    NSUInteger numberOfColumns =[self numberOfColumns];
    CGFloat leftM =[self marginForType:WaterFlowViewMarginLeft];
    CGFloat rightM =[self marginForType:WaterFlowViewMarginRight];
    CGFloat columnM =[self marginForType:WaterFlowViewMarginColumn];
    return (self.frame.size.width-leftM-rightM-(numberOfColumns-1)*columnM)/numberOfColumns;
}
-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    __block YLWaterFlowCell *cell;
    [self.resuableCells enumerateObjectsUsingBlock:^(YLWaterFlowCell *obj, BOOL *stop) {
        if (obj.identity==identifier) {
            cell = obj;
            *stop =YES;
        }
        
    }];
    if (cell) {
        //从缓存中移除当前项
        [self.resuableCells removeObject:cell];
    }
    return cell;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (![self.waterflowDelegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) {
        return;
    }
    UITouch *currentTouch =[touches anyObject]; 
    CGPoint currentPoint =[currentTouch locationInView:self];
     __block NSString *selectIndex =nil;
    //遍历可见视图 判断point点是那个view
   [self.displayIngCells enumerateKeysAndObjectsUsingBlock:^(NSString *key, YLWaterFlowCell *cell, BOOL *stop) {
       if (CGRectContainsPoint(cell.frame, currentPoint)) {
          selectIndex =key ;
           *stop =YES;
       }
       
   }];
    if (selectIndex!=nil) {
        [self.waterflowDelegate waterflowView:self didSelectAtIndex:[selectIndex integerValue]];
    }
}
/**
 *  根据path获取对应的waterfloweview
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
-(YLWaterFlowCell *)waterViewCellForRowAtIndex:(NSUInteger *)index{
    YLWaterFlowCell *cell=nil;
    if (self.displayIngCells) {
       cell =  [self.displayIngCells objectForKey:[NSString stringWithFormat:@"%d",index]];
    }
    return cell;
}
-(void)dealloc{
    YLLog(@"waterflow view dealloc");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
