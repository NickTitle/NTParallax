//
//  NTParallaxStackController.h
//  NTParallax
//
//  Created by Nick Esposito on 7/10/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTMotionReporter.h"
#import "NTParallaxLayer.h"

@interface NTParallaxStackController : UIViewController

@property (nonatomic, retain) NTMotionReporter *nTMR;


- (NTParallaxLayer *) addLayerToPStack:(UIView *)view motionRange:(double)mR origin:(CGPoint)origin;
- (NTParallaxLayer *) insertLayerIntoPStack:(UIView *)view atIndex:(int)index motionRange:(double)mR origin:(CGPoint)origin;
- (NTParallaxLayer *) addLayerToPStack:(UIView *)view vRange:(double)vMR hRange:(double)hMR origin:(CGPoint)origin;
- (NTParallaxLayer *) insertLayerIntoPStack:(UIView *)view atIndex:(int)index vRange:(double)vMR hRange:(double)hMR origin:(CGPoint)origin;

- (void) removeLayerFromPStack:(NTParallaxLayer *)layer;
- (void) showLayerInPStack:(NTParallaxLayer *)layer;
- (void) hideLayerFromPStack:(NTParallaxLayer *)layer;

- (NSArray *)pStack;
@end
