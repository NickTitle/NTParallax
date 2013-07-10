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
    
        
        UIButton *resetFrameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [resetFrameButton setFrame:CGRectMake(22, 22, self.view.frame.size.width-88, 88)];
        [resetFrameButton setTitle:@"Click to reset zero point" forState:UIControlStateNormal];
        [resetFrameButton addTarget:self action:@selector(resetFrameNotification) forControlEvents:UIControlEventTouchUpInside];
        
        [self setupParallaxControls];
        
        [self.view addSubview:resetFrameButton];
        
        
    }
    return self;
}

- (void) setupParallaxControls {
    sC = [NTParallaxStackController new];
    [self.view addSubview:sC.view];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, -10, 350, 462)];
    [bottomView setImage:[UIImage imageNamed:@"testBG.jpg"]];
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 175, 250, 300)];
    [topView setImage:[UIImage imageNamed:@"testFG.png"]];
    
    [sC addLayerToPStack:bottomView motionRange:100 origin:CGPointMake(-10, 100)];
    [sC addLayerToPStack:topView vRange:-60 hRange:-120 origin:CGPointMake(30, 300)];
    
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
