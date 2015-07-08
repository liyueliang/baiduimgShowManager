//
//  YLSettingCellTableViewCell.m
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLSettingCell.h" 
#import "YLSettingSwitchItem.h"
#import "YLSettingArrowItem.h"
#import "YLSettingLabelItem.h"
@interface YLSettingCell()
@property(nonatomic,strong) UIImageView *arrowView;
@property(nonatomic,strong) UISwitch *switchView;
@property(nonatomic,strong) UILabel *labelView;
@property(nonatomic,weak) UIView *dividerView;
@end
@implementation YLSettingCell
-(UIImageView *)arrowView{
    if (_arrowView==nil) {
        _arrowView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}
-(UISwitch *)switchView{
    if (_switchView==nil) {
        _switchView =[[UISwitch alloc]init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}
-(void)switchStateChange{
    if (self.item.key) {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setBool:self.switchView.isOn forKey:self.item.key];
        [defaults synchronize];
    }

}
-(UILabel *)labelView{
    if (_labelView==nil) {
        _labelView =[[UILabel alloc]init];
        _labelView.bounds=CGRectMake(0, 0, 100, 30);
        _labelView.text=self.item.subTitle;
        _labelView.backgroundColor=[UIColor clearColor];
        _labelView.textAlignment=UITextAlignmentRight;
    }
    return _labelView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置分割线
        if (!IOS7) {
             [self setupDivider];
        }
       
        //设置普通状态的背景
        [self setupBg];
        //设置选中的背景
        [self setupSubViews];
    }
    return self;
}
-(void)setupDivider{
    UIView *divider =[[UIView alloc]init];
    divider.backgroundColor=[UIColor blackColor];
    divider.alpha=0.2;
    [self.contentView addSubview:divider];
    self.dividerView =divider;
}
-(void)setupBg{
    UIView *BgView =[[UIView alloc]init];
    BgView.backgroundColor=[UIColor whiteColor];
    self.backgroundView=BgView;
    
    UIView *selectedBg =[[UIView alloc]init];
    selectedBg.backgroundColor=ylColor(237, 233, 218);
    self.selectedBackgroundView=selectedBg;
}
-(void)setupSubViews{
    self.textLabel.backgroundColor=[UIColor clearColor];
    self.detailTextLabel.backgroundColor=[UIColor clearColor];
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIdentity =@"cellIdentity";
    YLSettingCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (cell==nil){
        cell=[[YLSettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentity];
    }
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (IOS7) return;
    //设置分割线的frame
    CGFloat dividerH=1;
    CGFloat dividerW =[UIScreen mainScreen].bounds.size.width;
    CGFloat dividerX =0;
    CGFloat dividerY =self.contentView.frame.size.height-dividerH;
    self.dividerView.frame=CGRectMake(dividerX, dividerY, dividerW, dividerH);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(YLSettingItem *)item{
    _item = item;
    //1:设置数据
    [self setupData];
    //2:设置右边的内容
    [self setupRightContent];
}
-(void)setupData{
    if (self.item.icon) {
        self.imageView.image =[UIImage imageNamed:self.item.icon];
    }
    
    self.textLabel.text=self.item.title;
    self.detailTextLabel.text =self.item.subTitle;
}
-(void)setupRightContent{
  self.accessoryType = UITableViewCellAccessoryNone;
   if([self.item isKindOfClass:[YLSettingSwitchItem class]]) //开关
    {
        self.accessoryView=self.switchView;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (self.item.key) {
            NSUserDefaults *currentDfaults =[NSUserDefaults standardUserDefaults];
            
            self.switchView.on =[currentDfaults boolForKey:self.item.key];
        }
       
    }else if ([self.item isKindOfClass:[YLSettingArrowItem class]]) { //箭头
        self.accessoryView=self.arrowView;
    }else if ([self.item isKindOfClass:[YLSettingLabelItem class]]) { //label
        self.accessoryView=self.labelView;
    }
}
-(void)setFrame:(CGRect)frame{
    if (!IOS7) {
        CGFloat padding =10;
        frame.origin.x=-padding;
        frame.size.width+=padding*2;
    }
   
    [super setFrame:frame];
}
-(void)setLastRowInSection:(BOOL)lastRowInSection{
    _lastRowInSection = lastRowInSection;
    self.dividerView.hidden =lastRowInSection;
}
-(void)dealloc{
    YLLog(@"settingcell dealloc");
}
@end
