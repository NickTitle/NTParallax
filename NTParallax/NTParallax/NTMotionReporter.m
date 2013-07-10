//
//  NTMotionReporter.m
//  NTParallax
//
//  Created by Nick Esposito on 7/9/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import "NTMotionReporter.h"

static NTMotionReporter *mR;
NSDictionary *motionDict;

@implementation NTMotionReporter

@synthesize motionMan;
@synthesize motionUpdateQueue;

@synthesize rawPitch;
@synthesize rawRoll;
@synthesize calcPitch;
@synthesize calcRoll;

//These reference values can be set programmatically to let you receive values from the reference point of your user, instead of flat on a table
float refPitch = 0;
float refRoll = 0;

float cachePitch = 0;
float cacheRoll = 0;

//This is used similarly to old retain/release to prevent the app from grabbing data when it isn't needed
int activeRequestors = 0;


+ (NTMotionReporter *) singleReporter {
    if (mR == nil) {
        mR = [[super allocWithZone:NULL] init];
        NSLog(@"I've been called into existence!");
        
        [mR setupMotionManager];
        
        [notif addObserver:mR selector:@selector(orientToCurrentRotation) name:@"resetFrame" object:nil];
    }
    return mR;
}

- (void) setupMotionManager {
    if (motionMan == nil) {
        motionMan = [CMMotionManager new];
        motionUpdateQueue = [NSOperationQueue new];
        [motionMan startDeviceMotionUpdatesToQueue:motionUpdateQueue withHandler:^(CMDeviceMotion *motion, NSError *error){
            [self gatherMotion:motion andError:error];
        }];
        
        //Enable this method to use the automatic refpoint fixes below
//        [self enableAutomaticReferencePointReset];
        
    }
}

- (void) gatherMotion:(CMDeviceMotion *)motion andError:(NSError*)err {
    if (err == nil) {
        [self parseAndReportMotion:motion];
    }
    else {
        NSLog(@"Error reading motion : %@", err);
        [motionMan stopDeviceMotionUpdates];
    }
}

- (void) parseAndReportMotion:(CMDeviceMotion *)motion {

    cachePitch = motion.attitude.pitch;
    cacheRoll = motion.attitude.roll;
    
    calcPitch = cachePitch-refPitch;
    calcRoll = cacheRoll-refRoll;
    
//    NSLog(@"pitch:%1.3f roll:%1.3f", calcPitch, calcRoll);

    [notif postNotificationName:@"motionReported" object:nil];
}

// These optional methods reset your pitch and roll at 0 after a given time (defined in reference timer)
- (void) enableAutomaticReferencePointReset {
    NSTimer *referenceTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(orientToCurrentRotation) userInfo:nil repeats:YES];
    [referenceTimer fire];
}

- (void) orientToCurrentRotation {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Old vals => pitch:%f, roll:%f", refPitch, refRoll);
        refPitch = cachePitch;
        refRoll = cacheRoll;
        NSLog(@"New vals => pitch:%f, roll:%f", refPitch, refRoll);
    });
}

@end
