//
//  YLSectionView.m
//  BaiduImgShow
//
//  Created by jlt on 15/6/18.
//  Copyright (c) 2015年 junhe. All rights reserved.
//



#import "YLSectionView.h"
#import "UIImage+YL.h"
#define YLSectionViewButtonItemOfWidth   60
#define YLSectionViewButtonItemOfHeight  40
#define YLSectionViewButtonItemOfMarginLeft 5
#define YLSectionViewButtonItemOfMarginRight 5
#define YLSectionViewScreenWidth [UIScreen mainScreen].bounds.size.width






@interface YLSectionView()<UIScrollViewDelegate>
//@property(nonatomic,weak) YLSelectdBgView *selectBgView;
@property(nonatomic,weak) UIImageView *selectBgView;
@property(nonatomic,weak) UIScrollView *subScrollView;
@property(nonatomic,weak) UIScrollView *sectionScrollView;
@property(nonatomic,assign) NSInteger selectedIndex;
@end
@implementation YLSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        //设置scrollView属性
        //添加类别视图
        UIScrollView *sectionScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, YLSectionViewScreenWidth, YLSectionViewButtonItemOfHeight)];
        [sectionScrollView setShowsHorizontalScrollIndicator:NO];
        [sectionScrollView setShowsVerticalScrollIndicator:NO];
        [sectionScrollView setPagingEnabled:YES];
        [sectionScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"segent_background"]]];
        [sectionScrollView setDelegate:self];
        sectionScrollView.tag=101;
        [self addSubview:sectionScrollView];
        self.sectionScrollView =sectionScrollView;
        //添加分割线
        UIView *splitView =[[UIView alloc]initWithFrame:CGRectMake(0, YLSectionViewButtonItemOfHeight-1, YLSectionViewScreenWidth, 1)];
        [splitView setBackgroundColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];
        [self.sectionScrollView addSubview:splitView];
        
        //创建选中背景视图

        UIImageView *bgView =[[UIImageView alloc]initWithFrame:CGRectMake(0+YLSectionViewButtonItemOfMarginLeft, 5, YLSectionViewButtonItemOfWidth, YLSectionViewButtonItemOfHeight-10)];
        [bgView setImage:[UIImage resizedImageWithName:@"segent_item_selected"]];
        [self.sectionScrollView addSubview:bgView];
        self.selectBgView=bgView;
        
        //子视图
      UIScrollView  *subScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, YLSectionViewButtonItemOfHeight, YLSectionViewScreenWidth, frame.size.height-YLSectionViewButtonItemOfHeight)]; 
        [subScrollView setShowsHorizontalScrollIndicator:NO];
        [subScrollView setShowsVerticalScrollIndicator:NO];
        [subScrollView setPagingEnabled:YES];
        [subScrollView setDelegate:self];
        subScrollView.tag=100;
        [self addSubview:subScrollView];
        self.subScrollView =subScrollView;
     
        
        
    }
    return self;
}
 

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==100) {
        CGFloat pageWidth =scrollView.frame.size.width;
        int page=floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
        //开启一个动画
        [UIView animateWithDuration:0.5 animations:^{
             float buttonX = page*(YLSectionViewButtonItemOfWidth+YLSectionViewButtonItemOfMarginRight)+YLSectionViewButtonItemOfMarginLeft;
            CGRect tempRect =self.selectBgView.frame;
            CGPoint tempPoint = tempRect.origin;
            tempPoint.x =buttonX;
            tempRect.origin=tempPoint;
            self.selectBgView.frame=tempRect;
            
            //当前buttonX+margin+width>屏宽
            
        } completion:^(BOOL finished) {
            
            
        }];
    }else if(scrollView.tag==101){//section类别视图
        YLLog(@"ssssss");
    }
  
}
-(void)setSubViewControllers:(NSArray *)subViewControllers{
    _subViewControllers =subViewControllers;
    //清除原来已存在的子视图
    [self.subScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (subViewControllers) {
        //设置子视图
        [self setupSegentSubView];
        

    }
    
} 
-(void)setupSegentSubView{
    float W =self.subScrollView.frame.size.width;
    float H =self.subScrollView.frame.size.height;
    for (int i=0; i<self.subViewControllers.count; i++) {
        UIViewController *currentViewController =[self.subViewControllers objectAtIndex:i];
        
        
        //计算每个button对应的x
        float buttonX = i*(YLSectionViewButtonItemOfWidth+YLSectionViewButtonItemOfMarginRight)+YLSectionViewButtonItemOfMarginLeft;
        //创建button
        UIButton *buttonItem =[UIButton buttonWithType:UIButtonTypeCustom];
        buttonItem.frame =CGRectMake(buttonX, 0, YLSectionViewButtonItemOfWidth, YLSectionViewButtonItemOfHeight);
        //设置button对应的文字
        [buttonItem setTitle:currentViewController.title forState:UIControlStateNormal];
        [buttonItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //添加button点击事件
        [buttonItem addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //设置butotn tag值
        [buttonItem setTag:i];
        //添加button
        [self.sectionScrollView addSubview:buttonItem];

        
        
        
        currentViewController.view.frame=CGRectMake(i*W, 0, W, H);
        [self.subScrollView addSubview:currentViewController.view];
    }
    //设置contentSize
    float width = self.subViewControllers.count*W;
    self.subScrollView.contentSize =CGSizeMake(width, H);
    
    //设置contentSize
    float segentWidth = self.subViewControllers.count*(YLSectionViewButtonItemOfWidth+YLSectionViewButtonItemOfMarginRight)+YLSectionViewButtonItemOfMarginRight;
    self.sectionScrollView.contentSize =CGSizeMake(segentWidth, YLSectionViewButtonItemOfHeight);
}
/**
 *  按钮点击事件处理函数
 *
 *  @param btn <#btn description#>
 */
-(void)btnClick:(UIButton *)btn{
    if (![self.sectionDelegate respondsToSelector:@selector(sectionView:didSelectedSectionItem:)]) {
        return;
    }
    
    self.selectedIndex = btn.tag;
    //开启一个动画
    [UIView animateWithDuration:0.5 animations:^{
        self.selectBgView.center=btn.center;
        //切换子视图显示位置
        self.subScrollView.contentOffset =CGPointMake(self.selectedIndex*YLSectionViewScreenWidth, 0);
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    //通知delegate 实现点击处理
    [self.sectionDelegate sectionView:self didSelectedSectionItem:btn.titleLabel.text];
}

@end
