//
//  YLWaterFlowCell.h
//  BaiduImgShow
//
//  Created by lyl on 15/6/21.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLWaterFlowView;


/**
 *  waterflowcell 视图
 */
@interface YLWaterFlowCell : UIImageView
@property(nonatomic,copy)NSString *identity;
+(instancetype)cellWithWaterFlowView:(YLWaterFlowView *)waterFlowView;
@end
