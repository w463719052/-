//
//  YGTimeQuantumChooseView.m
//  测试
//
//  Created by zccl2 on 16/1/8.
//  Copyright © 2016年 Wyg. All rights reserved.
//

#import "YGTimeQuantumChooseView.h"

@interface YGTimeQuantumChooseView ()
{
    UIButton *_timeChooseButton;/**< 时间选择按钮*/
    UILabel *_timeLbl;/**< 时间*/
}
@end

@implementation YGTimeQuantumChooseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    return self;
}

#pragma mark 添加主要视图
- (void)addContentView {
    _timeChooseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _timeChooseButton.backgroundColor = [UIColor lightGrayColor];
    _timeChooseButton.frame = CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height);
    [_timeChooseButton setTitle:@"本月" forState:UIControlStateNormal];/**< 默认选择的时间段*/
    [_timeChooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeChooseButton addTarget:self action:@selector(timeChooseButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeChooseButton];
    
    _timeLbl = [[UILabel alloc] init];
    _timeLbl.frame = CGRectMake(self.frame.size.width/3+10, 0, 2*self.frame.size.width/3-10, self.frame.size.height);
    _timeLbl.textColor = [UIColor colorWithRed:15/225.0 green:139/225.0 blue:176/225.0 alpha:1];
    _timeLbl.attributedText = [self getTimeText:[NSString stringWithFormat:@"%@-01 至 %@",[self getDate],[self getTime:0]]];/**< 默认显示的时间段*/
    _timeLbl.font = [UIFont systemFontOfSize:13];
    [self addSubview:_timeLbl];
}

#pragma mark 时间选择按钮被点击
- (void)timeChooseButtonPress {
    /**< 执行对应的代理方法*/
    if (self.delegate && [self.delegate respondsToSelector:@selector(YGTimeQuantumChooseViewTimeChooseButtonPress)]) {
        [self.delegate YGTimeQuantumChooseViewTimeChooseButtonPress];
    }
}
#pragma mark 需要显示的时间
- (void)timeChooseButtonSetTitle:(NSString *)title {
    [_timeChooseButton setTitle:title forState:UIControlStateNormal];
    if ([title isEqualToString:@"本月"]) {
        _timeLbl.attributedText = [self getTimeText:[NSString stringWithFormat:@"%@-01 至 %@",[self getDate],[self getTime:0]]];
    } else if ([title isEqualToString:@"近三个月"]) {
        _timeLbl.attributedText = [self getTimeText:[NSString stringWithFormat:@"%@ 至 %@",[self getTime:3],[self getTime:0]]];
    } else if ([title isEqualToString:@"近六个月"]) {
        _timeLbl.attributedText = [self getTimeText:[NSString stringWithFormat:@"%@ 至 %@",[self getTime:6],[self getTime:0]]];
    } else if ([title isEqualToString:@"本年度"]) {
        _timeLbl.attributedText = [self getTimeText:[NSString stringWithFormat:@"%@-01-01 至 %@",[self getYear],[self getTime:0]]];
    }
}
#pragma mark 设置显示时间的样式
- (NSAttributedString *)getTimeText:(NSString *)string {
    NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:string];
    [colorStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(11,1)];
    return colorStr;
}
#pragma mark 获取当前年份
- (NSString *)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    //获得当前时间的年
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSString *nowDate = [NSString stringWithFormat:@"%ld",(long)nowCmps.year];
    return nowDate;
}
#pragma mark 获取当前年月
- (NSString *)getDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitMonth | NSCalendarUnitYear;
    
    //获得当前时间的年月
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSString *nowDate = [NSString stringWithFormat:@"%ld-%02ld",(long)nowCmps.year,(long)nowCmps.month];
    return nowDate;
}
#pragma mark 获取时间段
- (NSString *)getTime:(int)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];/**< 年*/
    [adcomps setMonth:-month];/**< 时间段与当前月份相差多少*/
    [adcomps setDay:0];/**< 日*/
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date]  options:0];
    NSDateComponents *theCmps = [calendar components:unit fromDate:newdate];
    NSString *theDate = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)theCmps.year,(long)theCmps.month,(long)theCmps.day];
    return theDate;
}

@end
