//
//  YLSectionView.h
//  BaiduImgShow
//  栏目类别视图
//  Created by jlt on 15/6/18.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLSectionView;


@protocol YLSectionViewDelegte<NSObject>
@optional
-(void)sectionView:(YLSectionView *)sectionView didSelectedSectionItem:(NSString *)itemTitle;
-(void)scrollViewChagneWithAnmationButton:(NSInteger)index;
@end




@interface YLSectionView : UIView 
//代理 选中某一个按钮
@property(nonatomic,assign) id<YLSectionViewDelegte> sectionDelegate;
@property(nonatomic,strong) NSArray *subViewControllers;

@end


