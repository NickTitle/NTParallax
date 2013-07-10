//
//  NTMotionReporter.m
//  NTParallax
//
//  Created by Nick Esposito on 7/9/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import "NTMotionReporter.h"

static NTMotionReporter *mR;

@implementation NTMotionReporter

@synthesize motionMan;
@synthesize motionUpdateQueue;

+ (NTMotionReporter *) singleReporter {
    if (mR == nil) {
        mR = [[super allocWithZone:NULL] init];
        NSLog(@"I've been called into existence!");
        
        [mR setupMotionManager];
    }
    return mR;
}

- (void) setupMotionManager {
    if (motionMan == nil) {
        motionMan = [CMMotionManager new];
        motionUpdateQueue = [NSOperationQueue new];
        [motionMan startDeviceMotionUpdatesToQueue:motionUpdateQueue withHandler:^(CMDeviceMotion *motion, NSError *error){
            [self reportMotion:motion andError:error];
        }];
    }
}

- (void) reportMotion:(CMDeviceMotion *)motion andError:(NSError*)err {
    if (err == nil) {
        NSLog(@"%@", motion);
    }
    else {
        NSLog(@"Error reading motion : %@", err);
    }
}

@end
