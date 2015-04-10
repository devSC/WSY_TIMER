//
//  WSFlashBuyTimerView.h
//  WSY_TIMER
//
//  Created by YSC on 15/4/10.
//  Copyright (c) 2015年 WoWSai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, WSFlashBuyTimerViewType)  {
    WSFlashBuyTimerViewTypeHour,
    WSFlashBuyTimerViewTypeSec,
    WSFlashBuyTimerViewTypeNow,
};
@interface WSFlashBuyTimerView : UIView
@property (nonatomic, assign) WSFlashBuyTimerViewType viewType;
+ (WSFlashBuyTimerView *)timerView;
- (void)setTimerViewTypeWithStartTime: (NSString *)startTime endTime: (NSString *)endTime;

@end
