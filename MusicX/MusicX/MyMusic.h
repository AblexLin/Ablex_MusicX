//
//  MyMusic.h
//  MusicX
//
//  Created by 顾明轩 on 16/6/20.
//  Copyright © 2016年 顾明轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MarqueeLabel.h"            //滚动标签
#import "ASValueTrackingSlider.h"   //三方滑块
#import "myMusicTableViewCell.h"    //自定义表格单元
#define HEIGHT_PLAY_BTN         40  //播放按钮高度
#define HEIGHT_TAB_BAR          49  //标签栏的高度
#define HEIGHT_NAV_BAR          64  //导航栏的高度
#define HEIGHT_SCREEN       [UIScreen mainScreen].bounds.size.height    //屏幕高度
#define WIDTH_SCREEN        [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define RANDOM_PLAY_MODEL        0  //随机模式
#define AUTOMATIC_PLAY_MODEL     1  //顺序循环
#define SINGLE_PLAY_MODEL        2  //单曲循环
@interface MyMusic : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,AVAudioPlayerDelegate>
{
    //音乐表格和滚动视图
    UIScrollView *musicPlayerScrollView;
    UITableView *musicPlayertableview;
    
    //系统全局用
    NSTimer *refreshTimer;
    NSTimer *refreshLrc;
    AVAudioPlayer *player;
    NSMutableArray *songNames;
    int playModelValue;
    int globalCurrentRow;
    
    //小视图以及其控件
    UIView *minView;
    UIButton *popMusicPlayerViewBtn;
    UIButton *miniPlayAndPauseBtn;
    MarqueeLabel *miniSongNameLabel;
    MarqueeLabel *miniWholeNameLabel;
    UIProgressView *miniSongProgress;
    
    //大视图以及其控件
    UIView *maxView;
    UIView *maxViewForSongInfo;
    UIButton *playAndPauseBtn;
    UIButton *nextSongBtn;
    UIButton *lastSongBtn;
    UIButton *loveSongBtn;
    UIButton *menuListBtn;
    UIButton *playModelBtn;
    UILabel *songNameLabel;
    UISlider *songVolumeSlider;
    UISlider *systemVolumeSlider;
    ASValueTrackingSlider *songProgressSlider;
    
    //表格视图单元使用
    int cellSaveRow;
    BOOL cellFlag;
    
    //歌词显示用
    UITableView *lrcTableView;
    NSMutableArray *lrcCurrentTime;
    NSMutableArray *lrcCurrentLrc;
    NSIndexPath *lrcCurrentIndexPath;
    BOOL lrcIsReady;
    BOOL isUpdateLrc;
}

@end
