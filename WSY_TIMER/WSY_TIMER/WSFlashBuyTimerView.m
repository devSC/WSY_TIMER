
//
//  WSFlashBuyTimerView.m
//  WSY_TIMER
//
//  Created by YSC on 15/4/10.
//  Copyright (c) 2015年 WoWSai. All rights reserved.
//

#import "WSFlashBuyTimerView.h"
@interface WSFlashBuyTimerView ()

@property (weak, nonatomic) IBOutlet UIView *hView;
@property (weak, nonatomic) IBOutlet UILabel *hViewDay;
@property (weak, nonatomic) IBOutlet UILabel *hViewHour;

@property (weak, nonatomic) IBOutlet UIView *sView;
@property (weak, nonatomic) IBOutlet UILabel *sViewHour;
@property (weak, nonatomic) IBOutlet UILabel *sViewMin;
@property (weak, nonatomic) IBOutlet UILabel *sViewSec;


@property (weak, nonatomic) IBOutlet UIView *nView;

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger sec;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSTimeInterval endTimeInterval;
@end
@implementation WSFlashBuyTimerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//+ (WSFlashBuyTimerView *)timerViewWithType: (WSFlashBuyTimerViewType)type
+ (WSFlashBuyTimerView *)timerView
{
    WSFlashBuyTimerView *timerView = [[[NSBundle mainBundle] loadNibNamed:@"WSFlashBuyTimerView" owner:self options:nil] firstObject];
    return timerView;
}
- (void)awakeFromNib
{

    
}

- (void)setUpTheView
{
    switch (_viewType) {
        case WSFlashBuyTimerViewTypeHour: {
            self.hViewDay.layer.cornerRadius = 2.0f;
            self.hViewDay.layer.masksToBounds = YES;
            self.hViewHour.layer.cornerRadius = 2.0f;
            self.hViewHour.layer.masksToBounds = YES;
            self.hViewDay.text = [NSString stringWithFormat:@"%ld", _day];
            self.hViewHour.text = [NSString stringWithFormat:@"%ld", _hour];
            //开启倒计时
            [self startTimer];
        }break;
        case WSFlashBuyTimerViewTypeSec: {
            self.sViewHour.layer.cornerRadius = 2.0f;
            self.sViewHour.layer.masksToBounds = YES;
            self.sViewMin.layer.cornerRadius = 2.0f;
            self.sViewMin.layer.masksToBounds = YES;
            self.sViewSec.layer.cornerRadius = 2.0f;
            self.sViewSec.layer.masksToBounds = YES;
            self.sViewHour.text = [NSString stringWithFormat:@"%ld", _hour];
            self.sViewMin.text = [NSString stringWithFormat:@"%ld", _minutes];
            self.sViewSec.text = [NSString stringWithFormat:@"%ld", _sec];
            //开启倒计时
            [self startTimer];
        }break;
        default:
            break;
    }
    
}
- (void)setTimerViewTypeWithStartTime: (NSString *)startTime endTime: (NSString *)endTime
{
    self.viewType = [self typeWithStartTime:startTime endTime:endTime];
    [self updateViewHidden];
}

- (void)updateViewHidden
{
    switch (_viewType) {
        case WSFlashBuyTimerViewTypeHour: {
            self.hView.hidden = NO;
            self.sView.hidden = YES;
            self.nView.hidden = YES;
        }break;
        case WSFlashBuyTimerViewTypeSec: {
            self.hView.hidden = YES;
            self.sView.hidden = NO;
            self.nView.hidden = YES;
        }break;
        case WSFlashBuyTimerViewTypeNow: {
            self.hView.hidden = YES;
            self.sView.hidden = YES;
            self.nView.hidden = NO;
        }break;
            
        default:
            break;
    }
    [self setUpTheView];
}
- (void)startTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateViewTimers) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

    [_timer fire];
}
- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)updateViewTimers
{
    self.endTimeInterval -=1;
    //如果已经开始抢购
    if (self.endTimeInterval == 0) {
        self.viewType = WSFlashBuyTimerViewTypeNow;
        [self updateViewHidden];
        [self invalidateTimer];
    } else {
        _day = ((int)_endTimeInterval)/(3600*24);
        _hour = ((int)_endTimeInterval)%(3600*24)/3600;
        _minutes = ((int)_endTimeInterval)%(3600*24)%3600/60;
        _sec = ((int)_endTimeInterval)%(3600*24)%3600%60;
        
        if (_day == 0) { //进入24小时内
            if (self.viewType != WSFlashBuyTimerViewTypeSec) {
                self.viewType = WSFlashBuyTimerViewTypeSec;
                [self updateViewHidden];
                return;
            }
            self.sViewHour.text = [NSString stringWithFormat:@"%ld", _hour];
            self.sViewMin.text = [NSString stringWithFormat:@"%ld", _minutes];
            self.sViewSec.text = [NSString stringWithFormat:@"%ld", _sec];
        }else {
            self.hViewDay.text = [NSString stringWithFormat:@"%ld", _day];
            self.hViewHour.text = [NSString stringWithFormat:@"%ld", _hour];
        }
    }
}

- (WSFlashBuyTimerViewType)typeWithStartTime: (NSString *)startTime endTime: (NSString *)endTime
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *  senddate=[NSDate dateWithTimeIntervalSince1970:startTime.integerValue];
    //结束时间
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime.integerValue];
    //当前时间
    NSDate *senderDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:senddate]];
    //得到相差秒数
     self.endTimeInterval =[endDate timeIntervalSinceDate:senderDate];
     _day = ((int)_endTimeInterval)/(3600*24);
    _hour = ((int)_endTimeInterval)%(3600*24)/3600;
    _minutes = ((int)_endTimeInterval)%(3600*24)%3600/60;
    _sec = ((int)_endTimeInterval)%(3600*24)%3600%60;
    if (_day > 0) {
        return WSFlashBuyTimerViewTypeHour;
    }
    if (_sec >= 0) {
        return WSFlashBuyTimerViewTypeSec;
    }
    return WSFlashBuyTimerViewTypeNow;


//    if (days <= 0&&hours <= 0&&minute <= 0)
//        dateContent=@"0天0小时0分钟";
//    else
//        dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];
//    return dateContent;
}

- (NSString *)intervalSinceData: (NSString *) theDate toData: (NSString *)toDate
{
    NSDate *  senddate=[NSDate dateWithTimeIntervalSince1970:theDate.integerValue];
    //结束时间
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:toDate.integerValue];
    //当前时间
//    NSDate *senderDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:senddate]];
    //得到相差秒数
    NSTimeInterval time=[endDate timeIntervalSinceDate:senddate];
    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)%3600/60;
    NSString *dateContent = nil;
    if (days <= 0&&hours <= 0&&minute <= 0)
        dateContent=@"0天0小时0分钟";
    else
        dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];
    return dateContent;
}

@end
