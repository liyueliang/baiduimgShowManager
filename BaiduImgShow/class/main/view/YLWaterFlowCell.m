//
//  YLWaterFlowCell.m
//  BaiduImgShow
//
//  Created by lyl on 15/6/21.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLWaterFlowCell.h"
#import "YLWaterFlowView.h"
@implementation YLWaterFlowCell
+(instancetype)cellWithWaterFlowView:(YLWaterFlowView *)waterFlowView
{
    static NSString *cellIdentity =@"cells";
    YLWaterFlowCell *cell =[waterFlowView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell==nil) {
        cell =[[YLWaterFlowCell alloc] init];
        cell.identity = cellIdentity;
    }
    return cell;
}
@end
