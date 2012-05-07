//
//  ViewController.m
//  YouYangHelper
//
//  Created by Chu Kevin on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize startButton,pauseButton,cancelButton;
@synthesize aerobicsSlider,restSlider,loopSlider;
@synthesize aerobicsLable,restLable,loopLable;
@synthesize minute,second,millisecond;
@synthesize myTimer,restTimer;
@synthesize strSecond,strMinute,strMillisecond;
@synthesize intTotalTime,intRestTimes,intAerobicsTimes,intLooptimes;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void) myTimerAction:(NSTimer *) timer
{
  
 /*   if (intMillisecond%1000==0) {
       //intMillisecond=0;
        intSecond++;
    } */
    if (boolDoing) {
        strMillisecond = [NSString stringWithFormat:@"%@",@"A"];
    }else {
        strMillisecond = [NSString stringWithFormat:@"%@", @"R"];
    }
    intSecond++;
    if (intSecond%60==0) {
        intSecond=0;
        intMinute++;
        if((intMinute == intAerobicsTimes)&&(boolDoing==YES))
        {
            [self playSound];
            intMinute = 0;
            intLoopTimes--; 
            boolDoing=NO;
            if (intLoopTimes == 0)
            {
                
                [self cancelButtonClicked:nil];
                strMillisecond = [NSString stringWithFormat:@"%@", @"F"];
                [self playSound];
            }
        }
        else if ((intMinute == intRestTimes)&&(boolDoing==NO)){
            [self playSound];
            intMinute = 0;
            boolDoing = YES;
        }
    }
    if (intSecond<10) {
        strSecond = [NSString stringWithFormat:@"0%d", intSecond];
    }else {
        
    strSecond = [NSString stringWithFormat:@"%d", intSecond];
    }
    if(intMinute<10)
    {
        strMinute = [NSString stringWithFormat:@"0%d", intMinute];
    }else {
       strMinute = [NSString stringWithFormat:@"%d", intMinute];
    }
    
    [millisecond setText:strMillisecond];
    [second setText:strSecond];
    [minute setText:strMinute];
  
}
-(void)playSound
{
  //  NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:@"Tock" ofType:@"aiff"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Trill" ofType:@"mp3"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    AudioServicesPlaySystemSound(soundID);
      
}
-(void)startTimer
{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self 
                                             selector:@selector(myTimerAction:) userInfo:nil repeats:YES];
    
}
-(void)stopTimer
{
    [myTimer invalidate];
}
-(BOOL)isTimerValid
{
    if ([myTimer isValid]==YES) {
        return YES;
    }
    return NO;
}
-(IBAction) startButtonClicked:(id) sender
{
    [startButton setHidden:TRUE];
    [pauseButton setHidden:FALSE];
    [cancelButton setHidden:FALSE ];
    [self setTimerValue];
    [self startTimer];
    [self playSound];
    

}

-(IBAction)cancelButtonClicked:(id)sender
{
    if(boolPause==TRUE){
        [self pauseButtonClicked:nil];
    
    }
    [self stopTimer];
    [second setText:@"00"];
    [minute setText:@"00"];
    [millisecond setText:@"0"];
    [pauseButton setHidden:TRUE];
    [cancelButton setHidden:TRUE];
    [startButton setHidden:FALSE];
    intSecond=0;
    intMinute=0;
    boolDoing=YES;
}
-(IBAction)pauseButtonClicked:(id)sender
{
    if (boolPause) {
        [self startTimer];
        boolPause=FALSE;
        [pauseButton setTitle:@"Pause" forState:UIControlStateHighlighted];
        [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
    else{
        [pauseButton setTitle:@"Resume" forState:UIControlStateHighlighted];
        [pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
        if([self isTimerValid]==YES)
        {
            [self stopTimer];
        }
        boolPause=TRUE;
    }
}
-(void)setTimerValue
{
    intAerobicsTimes=[aerobicsSlider value];
    intRestTimes=[restSlider value];
    intLoopTimes=[loopSlider value];
    intTotalTime =( (intAerobicsTimes + intRestTimes) * intLoopTimes - intRestTimes)*60;
    
}
-(void)setAerobicsLable
{
    NSString *strAerobics = [NSString stringWithFormat:@"%d Minutes", intAerobicsTimes];
    [aerobicsLable setText:strAerobics];
}
-(void)setRestLable
{
    NSString *strRest = [NSString stringWithFormat:@"%d Minutes", intRestTimes];
    [restLable setText:strRest];
}
-(void)setLoopLable
{
    NSString *strLoop = [NSString stringWithFormat:@"%d Times", intLoopTimes];
    [loopLable setText:strLoop];
}
-(IBAction)aerobicsSliderChangeValue:(id)sender{
    UISlider *slider = (UISlider *) sender;
    intAerobicsTimes = (int)(slider.value);
    [self setAerobicsLable];
}
-(IBAction)restSliderChangeValue:(id)sender{
    UISlider *slider = (UISlider *) sender;
    intRestTimes = (int)(slider.value);
    [self setRestLable];
}
-(IBAction)loopSliderChangeValue:(id)sender{
    UISlider *slider = (UISlider *) sender;
    intLoopTimes = (int)(slider.value);
    [self setLoopLable];
}
- (void)viewDidLoad
{
    UIDevice* device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)])
        backgroundSupported = device.multitaskingSupported;
    if (backgroundSupported) {
        NSLog(@"Supported.");
    }
    else {
        NSLog(@"Not supported.");
    }
    boolDoing=YES;
    [self setTimerValue];   
    [self setAerobicsLable];
    [self setLoopLable];
    [self setRestLable];
    boolPause=FALSE;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{

    AudioServicesDisposeSystemSoundID(soundID);
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
