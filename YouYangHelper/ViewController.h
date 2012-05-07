//
//  ViewController.h
//  YouYangHelper
//
//  Created by Chu Kevin on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
@interface ViewController : UIViewController
{
    IBOutlet UISlider *aerobicsSlider;
    IBOutlet UISlider *restSlider;
    IBOutlet UISlider *loopSlider;
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UILabel *minute;
    IBOutlet UILabel *second;
    IBOutlet UILabel *millisecond;
    NSInteger intSecond;
    NSInteger intMillisecond;
    NSInteger intMinute;
    NSTimer *myTimer;
    NSTimer *restTimer;
    BOOL boolPause;
    BOOL boolDoing;
    NSInteger intAerobicsTimes;
    NSInteger intRestTimes;
    NSInteger intLoopTimes;
    NSInteger intTotalTime;
    NSString *strSecond;
    NSString *strMinute;
    IBOutlet UILabel *aerobicsLable;
    IBOutlet UILabel *restLable;
    IBOutlet UILabel *loopLable;
    SystemSoundID soundID;
    NSString *strMillisecond;

}
@property (nonatomic, retain) NSTimer *restTimer;
@property (nonatomic, retain) UILabel *aerobicsLable;
@property (nonatomic, retain) UILabel *restLable;
@property (nonatomic, retain) UILabel *loopLable;
@property (nonatomic, retain) NSString *strSecond;
@property (nonatomic, retain) NSString *strMinute;
@property (nonatomic, retain) NSString *strMillisecond;
@property (nonatomic, retain) NSTimer *myTimer;
@property (nonatomic, retain) UILabel *minute;
@property (nonatomic, retain) UILabel *second;
@property (nonatomic, retain) UILabel *millisecond;
@property (nonatomic, retain) UIButton *startButton;
@property (nonatomic, retain) UIButton *pauseButton;
@property (nonatomic, retain) UIButton *cancelButton;
@property (nonatomic, retain) UISlider *aerobicsSlider;
@property (nonatomic, retain) UISlider *restSlider;
@property (nonatomic, retain) UISlider *loopSlider;
@property (nonatomic, readwrite) NSInteger intAerobicsTimes;
@property (nonatomic, readwrite) NSInteger intRestTimes;
@property (nonatomic, readwrite) NSInteger intLooptimes;
@property (nonatomic, readwrite) NSInteger intTotalTime;
-(void)setAerobicsLable;
-(void)setRestLable;
-(void)setLoopLable;
-(void)playSound;
-(void)startTimer;
-(void)setTimerValue;
-(IBAction)cancelButtonClicked:(id)sender;
-(IBAction)pauseButtonClicked:(id)sender;
-(IBAction)startButtonClicked:(id) sender;

@end
