//
//  NTParallaxLayer.h
//  NTParallax
//
//  Created by Nick Esposito on 7/10/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface NTParallaxLayer : NSObject

@property (nonatomic, retain) UIView *parallaxView;
@property (nonatomic, assign) double verticalMotionRange;
@property (nonatomic, assign) double horizontalMotionRange;
@property (nonatomic, assign) double origX;
@property (nonatomic, assign) double origY;

- (id) initWithView:(UIView *)view motionRange:(double)mR origin:(CGPoint)origin;

- (id) initWithView:(UIView *)view vRange:(double)vR hRange:(double)hR origin:(CGPoint)origin;

- (void) updateViewFromNotification:(NSNotification *)n;

@end