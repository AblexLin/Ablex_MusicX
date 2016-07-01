//
//  MyTimer.m
//  MusicX
//
//  Created by 顾明轩 on 16/6/20.
//  Copyright © 2016年 顾明轩. All rights reserved.
//

#import "MyTimer.h"

@interface MyTimer ()

@end

@implementation MyTimer
@synthesize choseTableView,datePicker;
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.tintColor=[UIColor orangeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *upViewLine=[[UIView alloc]initWithFrame:CGRectMake(0, choseTableView.frame.origin.y-0.5, WIDTH_SCREEN, 0.5)];
    upViewLine.backgroundColor=[UIColor orangeColor];
    UIView *downViewLine=[[UIView alloc]initWithFrame:CGRectMake(0, choseTableView.frame.origin.y+choseTableView.frame.size.height, WIDTH_SCREEN, 0.5)];
    downViewLine.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:upViewLine];
    [self.view addSubview:downViewLine];
    
    float whiteSpace=(HEIGHT_SCREEN-HEIGHT_TAB_BAR-choseTableView.frame.origin.y-choseTableView.frame.size.height);//计算界面剩余空间
    float whiteSpaceOrigin=choseTableView.frame.origin.y+choseTableView.frame.size.height;//计算剩余空间起点
    
    pauseBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH_SCREEN/4-70/2, whiteSpaceOrigin+whiteSpace/2-70/2, 70, 70)];
    [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    pauseBtn.backgroundColor=[UIColor whiteColor];
    pauseBtn.layer.cornerRadius=35.0;
    pauseBtn.layer.masksToBounds=35.0;
    pauseBtn.layer.borderWidth=1.0;
    pauseBtn.layer.borderColor=[UIColor orangeColor].CGColor;
    [pauseBtn addTarget:self action:@selector(pauseCalculate:) forControlEvents:UIControlEventTouchUpInside];
    pauseBtn.enabled=NO;
    [self.view addSubview:pauseBtn];
    
    startBtn=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH_SCREEN*3/4-70/2, whiteSpaceOrigin+whiteSpace/2-70/2, 70, 70)];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    startBtn.backgroundColor=[UIColor whiteColor];
    startBtn.layer.cornerRadius=35.0;
    startBtn.layer.masksToBounds=35.0;
    startBtn.layer.borderWidth=1.0;
    startBtn.layer.borderColor=[UIColor orangeColor].CGColor;
    [startBtn addTarget:self action:@selector(startCalculate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    countDownLabel=[[UILabel alloc]initWithFrame:datePicker.frame];//日期显示文本
    countDownLabel.textColor=[UIColor orangeColor];
    countDownLabel.font=[UIFont fontWithName:@"Helvetica" size:70.0];
    countDownLabel.textAlignment=NSTextAlignmentCenter;
    countDownLabel.backgroundColor=[UIColor whiteColor];
    
    secondrefreshTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(secondTimer) userInfo:nil repeats:YES];
    refreshLabelTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshLabel) userInfo:nil repeats:YES];
    closePlayerTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closePlayer) userInfo:nil repeats:YES];
}
#pragma mark - NSTimer
-(void)closePlayer
{
    if (isCalculate && remainSecond==-1) {
        //结束相当于执行了取消按钮
        isCalculate=NO;//关闭计时
        [self timerSwitch:NO];
        pauseBtn.enabled=NO;
        [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [pauseBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [pauseBtn setBackgroundColor:[UIColor whiteColor]];
        datePicker.enabled=YES;
        [countDownLabel removeFromSuperview];
        [startBtn setTitle:@"开始" forState:UIControlStateNormal];
        [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [startBtn setBackgroundColor:[UIColor whiteColor]];
//        UIBackgroundTaskIdentifier taskID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//            //获取后台任务的id,睡眠下试试
//            //[NSThread sleepForTimeInterval:0.5];
//        }];
//
//        [[UIApplication sharedApplication] endBackgroundTask:taskID];

    }
}
-(void)refreshLabel
{
    NSArray *remainTimeArray=[self convertTimeRemain:remainSecond];
    countDownLabel.text=[NSString stringWithFormat:@"%@:%@:%@",remainTimeArray[0],remainTimeArray[1],remainTimeArray[2]];
}
-(void)secondTimer
{
    if (remainSecond>=0) {
        remainSecond=remainSecond-1;
    }
    NSLog(@"%d",remainSecond);
}

#pragma mark start pause button
-(void)pauseCalculate:(UIButton *)sender
{
    //变化按钮颜色
    if ([sender.titleLabel.text isEqualToString:@"暂停"]) {
        [self timerSwitch:NO];//关闭计时器
        [sender setTitle:@"继续" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor orangeColor]];
    }
    else{
        [self timerSwitch:YES];//开启计时器
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor whiteColor]];
    }
}
-(void)startCalculate:(UIButton *)sender
{
    //变化按钮颜色
    if ([sender.titleLabel.text isEqualToString:@"开始"]) {
        remainSecond=[self convertTime:datePicker.date];
        pauseBtn.enabled=YES;
        [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        datePicker.enabled=NO;
        [self.view addSubview:countDownLabel];
        [sender setTitle:@"取消" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor orangeColor]];
        
        isCalculate=YES;//开始计时
        [self timerSwitch:YES];
    }
    else{
        isCalculate=NO;//关闭计时
        [self timerSwitch:NO];
        
        pauseBtn.enabled=NO;
        [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [pauseBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [pauseBtn setBackgroundColor:[UIColor whiteColor]];
        datePicker.enabled=YES;
        [countDownLabel removeFromSuperview];
        [sender setTitle:@"开始" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor whiteColor]];
    }
}
-(void)timerSwitch:(BOOL)_isSwitchOn
{
    if (_isSwitchOn) {
        [secondrefreshTimer invalidate];//先关闭定时器，再开启
        secondrefreshTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(secondTimer) userInfo:nil repeats:YES];
        [closePlayerTimer invalidate];
        closePlayerTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closePlayer) userInfo:nil repeats:YES];
        [refreshLabelTimer invalidate];
        refreshLabelTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshLabel) userInfo:nil repeats:YES];
    }
    else{
        [secondrefreshTimer invalidate];
        [refreshLabelTimer invalidate];
        [closePlayerTimer invalidate];
    }
}
#pragma mark - timeAndInt convert itsself
-(NSArray *)convertTimeRemain:(int)_remainTime
{
    int hour=_remainTime/3600;
    int minute=_remainTime%3600/60;
    int second=_remainTime%3600%60;
    NSString *hourStr;
    NSString *minuteStr;
    NSString *secondStr;
    if (hour<10) {
        hourStr=[NSString stringWithFormat:@"0%d",hour];
    }
    else{
        hourStr=[NSString stringWithFormat:@"%d",hour];
    }
    if (minute<10) {
        minuteStr=[NSString stringWithFormat:@"0%d",minute];
    }
    else{
        minuteStr=[NSString stringWithFormat:@"%d",minute];
    }
    if (second<10) {
        secondStr=[NSString stringWithFormat:@"0%d",second];
    }
    else{
        secondStr=[NSString stringWithFormat:@"%d",second];
    }
    return [NSArray arrayWithObjects:hourStr,minuteStr,secondStr, nil];
}
-(int)convertTime:(NSDate *)_date
{
    NSDateFormatter *format=[[NSDateFormatter alloc]init];  //初始化一个NSDateFormatter对象
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];          //固定格式,mm表示分钟,MM表示月,HH表示24小时制
    NSString *oldDateStr=[format stringFromDate:_date];      //点击按钮时候，记录下时间
    NSArray *array=[oldDateStr componentsSeparatedByString:@" "];
    NSString *time=array[1];
    NSRange hour={0,2};
    NSRange minute={3,2};
    NSRange second={6,2};
    NSString *timeForHour=[time substringWithRange:hour];
    NSString *timeForMinute=[time substringWithRange:minute];
    NSString *timeForSecond=[time substringWithRange:second];
    NSLog(@"%@%@%@",timeForHour,timeForMinute,timeForSecond);
    int wholeSecond=[timeForHour intValue]*3600 + [timeForMinute intValue]*60 +0;//秒总是清零开始
    return wholeSecond;
}
#pragma mark - choseTableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text=@"计时方式选择";
    cell.textLabel.textColor=[UIColor orangeColor];
    cell.detailTextLabel.text=@"停止音乐";
    cell.detailTextLabel.textColor=[UIColor orangeColor];
    cell.detailTextLabel.alpha=0.5;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor orangeColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
