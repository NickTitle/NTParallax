//
//  NTParallaxStackController.m
//  NTParallax
//
//  Created by Nick Esposito on 7/10/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import "NTParallaxStackController.h"

@implementation NTParallaxStackController

@synthesize nTMR;

NSMutableArray *pStack;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pStack];
    nTMR = [NTMotionReporter singleReporter];
	// Do any additional setup after loading the view.
}

- (NTParallaxLayer *) addLayerToPStack:(UIView *)view motionRange:(double)mR origin:(CGPoint)origin {
    NTParallaxLayer *newLayer = [[NTParallaxLayer alloc] initWithView:view motionRange:mR origin:origin];
    [self addToPStack:newLayer];
    return newLayer;
}

- (NTParallaxLayer *) insertLayerIntoPStack:(UIView *)view atIndex:(int)index motionRange:(double)mR origin:(CGPoint)origin {
    NTParallaxLayer *newLayer = [[NTParallaxLayer alloc] initWithView:view motionRange:mR origin:origin];
    [self insertIntoPStack:newLayer atIndex:index];
    return newLayer;
}

- (NTParallaxLayer *) addLayerToPStack:(UIView *)view vRange:(double)vMR hRange:(double)hMR origin:(CGPoint)origin {
    NTParallaxLayer *newLayer = [[NTParallaxLayer alloc] initWithView:view vRange:vMR hRange:hMR origin:origin];
    [self addToPStack:newLayer];
    return newLayer;
}

- (NTParallaxLayer *) insertLayerIntoPStack:(UIView *)view atIndex:(int)index vRange:(double)vMR hRange:(double)hMR origin:(CGPoint)origin {
    NTParallaxLayer *newLayer = [[NTParallaxLayer alloc] initWithView:view vRange:vMR hRange:hMR origin:origin];
    [self insertIntoPStack:newLayer atIndex:index];
    return newLayer;
}

- (void) removeLayerFromPStack:(NTParallaxLayer *)layer {
    [layer.parallaxView removeFromSuperview];
}

- (void) showLayerInPStack:(NTParallaxLayer *)layer {
    [layer.parallaxView setAlpha:1];
}

- (void) hideLayerFromPStack:(NTParallaxLayer *)layer {
    [layer.parallaxView setAlpha:0];
}


- (NSMutableArray *)pStack {
    if (pStack == nil) {
        pStack = [NSMutableArray new];
    }
    return pStack;
}

- (void)addToPStack:(NTParallaxLayer *)pL {
    [pStack addObject:pL];
    [notif addObserver:pL selector:@selector(updateViewFromNotification:) name:@"motionReported" object:nil];
    [self.view addSubview:pL.parallaxView];
    [nTMR motionReporterShouldReport:true];
}

- (void)insertIntoPStack:(NTParallaxLayer *)pL atIndex:(int)index {
    [pStack insertObject:pL atIndex:index];
    [self.view insertSubview:pL.parallaxView atIndex:index];
    [nTMR motionReporterShouldReport:true];
}

- (void)removeFromPStack:(NTParallaxLayer *)pL {
    [pStack removeObject:pL];
    [notif removeObserver:pL name:@"motionReported" object:nil];
    [pL.parallaxView removeFromSuperview];
    if ([pStack count] == 0) {
        [nTMR motionReporterShouldReport:FALSE];
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
