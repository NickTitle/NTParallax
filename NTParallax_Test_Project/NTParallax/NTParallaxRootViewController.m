//
//  NTParallaxRootViewController.m
//  NTParallax
//
//  Created by Nick Esposito on 7/10/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import "NTParallaxRootViewController.h"

@interface NTParallaxRootViewController ()

@end

@implementation NTParallaxRootViewController

@synthesize sC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        
//        UIButton *resetFrameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [resetFrameButton setFrame:CGRectMake(22, 22, self.view.frame.size.width-88, 88)];
//        [resetFrameButton setTitle:@"Click to reset zero point" forState:UIControlStateNormal];
//        [resetFrameButton addTarget:self action:@selector(resetFrameNotification) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:resetFrameButton];        
        
        [self setupParallaxControls];
        

        
        
    }
    return self;
}

- (void) setupParallaxControls {
    sC = [NTParallaxStackController new];
    [self.view addSubview:sC.view];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500, 700)];
    [bottomView setImage:[UIImage imageNamed:@"testBG.jpg"]];
    
    UIView *midView = [[UIView alloc] initWithFrame:iP5Frame];
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(0, 88, 320, 276)];
    [headline setBackgroundColor:[UIColor clearColor]];
    [headline setNumberOfLines:0];
    [headline setFont:[UIFont boldSystemFontOfSize:64]];
    [headline setTextAlignment:NSTextAlignmentCenter];
    [headline setTextColor:[UIColor whiteColor]];
    [headline setText:@"AND YET \nIT MOVES"];
    [midView addSubview:headline];
    
    UIImageView *earthView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
    [earthView setImage:[UIImage imageNamed:@"testEarth.png"]];
    UITapGestureRecognizer *earthTap = [UITapGestureRecognizer new];
    [earthTap addTarget:self action:@selector(resetFrameNotification)];
    [earthView addGestureRecognizer:earthTap];
    [earthView setUserInteractionEnabled:TRUE];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 350, 320, 44)];
    UILabel *headline2 = [UILabel new];
    [headline2 setFrame:CGRectMake(0, 0, 320, 44)];
    [headline2 setBackgroundColor:[UIColor clearColor]];
    [headline2 setNumberOfLines:0];
    [headline2 setTextAlignment:NSTextAlignmentCenter];
    [headline2 setTextColor:[UIColor whiteColor]];
    [headline2 setText:@"Click earth to reset zero point"];
    [headline2 setFont:[UIFont systemFontOfSize:18]];
    [topView addSubview:headline2];
    
    
    [sC addLayerToPStack:bottomView motionRange:-250 origin:CGPointMake(-90, -90)];

    [sC addLayerToPStack:midView motionRange:-200 origin:CGPointMake(0, 0)];

    [sC addLayerToPStack:earthView motionRange:-80 origin:CGPointMake(70, 225)];
    
    [sC addLayerToPStack:topView motionRange:80 origin:CGPointMake(0, 350)];

}

- (void) resetFrameNotification {
    [notif postNotificationName:@"resetFrame" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
