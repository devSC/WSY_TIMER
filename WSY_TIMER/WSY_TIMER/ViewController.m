//
//  ViewController.m
//  WSY_TIMER
//
//  Created by YSC on 15/4/9.
//  Copyright (c) 2015年 WoWSai. All rights reserved.
//

#import "ViewController.h"
#import "WSFlashBuyTimerView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *backView2;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (nonatomic, strong) CATextLayer *layer1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//https://github.com/jaydee3/JDFlipNumberView
//    https://github.com/mineschan/MZTimerLabel     CATextLayer
    _layer1 = [CATextLayer layer];
    _layer1.contentsScale = [UIScreen mainScreen].scale;
    _layer1.frame = CGRectMake(0, 0, 30, 40);
    _layer1.string = @"哈";
    _layer1.backgroundColor = [UIColor redColor].CGColor;
//    _layer1.foregroundColor = [UIColor yellowColor].CGColor;
    _layer1.cornerRadius = 3.0f;
    _layer1.fontSize = 25;
    _layer1.wrapped = YES;
    _layer1.masksToBounds = YES;
    _layer1.alignmentMode = kCAAlignmentCenter;
//    _layer1.truncationMode = @"middle";
    [_backView2.layer addSublayer:_layer1];
//     1428422400
//    1428595199
    NSString *time1 = @"1428422400";
    NSString *time2 = @"1430508810";
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time1.integerValue];
    NSLog(@"1428422400  = %@",confromTimesp);
    confromTimesp = [NSDate dateWithTimeIntervalSince1970:time2.integerValue];
    NSLog(@"1430508810  = %@",confromTimesp);
    NSString *timeString = [self intervalSinceData:time1 toData:time2];
    NSLog(@"%@", timeString);
    
    NSString *now = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    WSFlashBuyTimerView *timerView = [WSFlashBuyTimerView timerView];
    [timerView setTimerViewTypeWithStartTime:time1 endTime:time2];
    [timerView setFrame:CGRectMake(0, 0, 200, 100)];
    [timerView setCenter:self.view.center];
    [self.view addSubview:timerView];

    
}
- (NSString *)intervalSinceData: (NSString *) theDate toData: (NSString *)toDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *  senddate=[NSDate dateWithTimeIntervalSince1970:theDate.integerValue];
    //结束时间
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:toDate.integerValue];
    //当前时间
    NSDate *senderDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:senddate]];
    //得到相差秒数
    NSTimeInterval time=[endDate timeIntervalSinceDate:senderDate];
    
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

- (IBAction)changeButton:(id)sender {
    NSArray *array = @[@"哈", @"嘿嘿", @"啊哈哈", @"欧欧哒哒", @"溪欧欧哒哒"];
    _layer1.string = [array objectAtIndex:arc4random()%5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
