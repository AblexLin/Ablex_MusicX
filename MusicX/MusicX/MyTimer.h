//
//  MyTimer.h
//  MusicX
//
//  Created by 顾明轩 on 16/6/20.
//  Copyright © 2016年 顾明轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#define HEIGHT_PLAY_BTN         40  //播放按钮高度
#define HEIGHT_TAB_BAR          49  //标签栏的高度
#define HEIGHT_NAV_BAR          64  //导航栏的高度
#define HEIGHT_SCREEN       [UIScreen mainScreen].bounds.size.height    //屏幕高度
#define WIDTH_SCREEN        [UIScreen mainScreen].bounds.size.width     //屏幕宽度
@interface MyTimer : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *countDownLabel;
    int remainSecond;
    NSTimer *secondrefreshTimer;
    NSTimer *refreshLabelTimer;
    NSTimer *closePlayerTimer;
    UIButton *pauseBtn;
    UIButton *startBtn;
    BOOL isCalculate;
}
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableView *choseTableView;
@end
