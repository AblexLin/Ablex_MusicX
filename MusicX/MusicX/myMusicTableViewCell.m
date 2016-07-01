//
//  myMusicTableViewCell.m
//  MusicX
//
//  Created by 顾明轩 on 16/6/24.
//  Copyright © 2016年 顾明轩. All rights reserved.
//

#import "myMusicTableViewCell.h"

@implementation myMusicTableViewCell

@synthesize playAndPause,songNameLabel,wholeNameLabel;
-(instancetype)init
{
    self = [super init];
    if (self) {
        //设置背景和获取本地按钮图片
//        self.backgroundColor=[UIColor blackColor];
        //播放按钮
        playAndPause=[UIButton buttonWithType:UIButtonTypeCustom];
        playAndPause.frame=CGRectMake(0, 5, 40, 40);
        [self addSubview:playAndPause];
        //歌曲名称
        songNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 270, 20)];
        songNameLabel.textAlignment = NSTextAlignmentLeft;
        songNameLabel.textColor = [UIColor lightGrayColor];
        songNameLabel.font = [UIFont systemFontOfSize:15.000];
        [self addSubview:songNameLabel];
        //歌曲信息
        wholeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 270, 20)];
        wholeNameLabel.textAlignment = NSTextAlignmentLeft;
        wholeNameLabel.textColor = [UIColor grayColor];
        wholeNameLabel.font = [UIFont systemFontOfSize:12.000];
        [self addSubview:wholeNameLabel];
        //自己画分割线
        UIView *separate=[[UIView alloc]initWithFrame:CGRectMake(10, 49.5, 300, 0.5)];
        separate.backgroundColor=[UIColor grayColor];
        [self addSubview:separate];
    }
    return self;
}
#pragma mark - 设置视图控件样式
-(void)setCellPlayAndPauseBtnIMG:(int)_tag andFlag:(BOOL)_flag
{
    if (playAndPause.tag==_tag && _flag==1) {
        [playAndPause setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nousenow_player_btn_pause_normal@2x" ofType:@"png"]] forState:UIControlStateNormal];
        songNameLabel.textColor=[UIColor greenColor];
    }
    else{
        [playAndPause setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nousenow_player_btn_play_normal@2x" ofType:@"png"]] forState:UIControlStateNormal];
    }
}
@end
