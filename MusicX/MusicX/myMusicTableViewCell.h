//
//  myMusicTableViewCell.h
//  MusicX
//
//  Created by 顾明轩 on 16/6/24.
//  Copyright © 2016年 顾明轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMusic.h"

@interface myMusicTableViewCell : UITableViewCell

@property (strong,nonatomic) UIButton *playAndPause;
@property (strong,nonatomic) UILabel *songNameLabel;
@property (strong,nonatomic) UILabel *wholeNameLabel;
-(void)setCellPlayAndPauseBtnIMG:(int)_tag andFlag:(BOOL)_flag;
@end
