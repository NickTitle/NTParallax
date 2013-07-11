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
bool isReportingMotion = 0;


+ (NTMotionReporter *) singleReporter {
    if (mR == nil) {
        mR = [[super allocWithZone:NULL] init];
        [mR setupMotionManager];
    }
    return mR;
}

- (void) setupMotionManager {
    if (motionMan == nil) {
        motionMan = [CMMotionManager new];
        //update interval set at 48 frames per second, so as not to waste power
        [motionMan setDeviceMotionUpdateInterval:.021];
        motionUpdateQueue = [NSOperationQueue new];
        
        [notif addObserver:self selector:@selector(orientToCurrentRotation) name:@"resetFrame" object:nil];
        
        //Enable this method to use the automatic refpoint fixes below
//        [self enableAutomaticReferencePointReset];
        
    }
}

// This method controls starting and stopping of motion reporting
- (void) motionReporterShouldReport:(BOOL)reportBool {
    if (reportBool) {
        if (isReportingMotion == false) {
            [motionMan startDeviceMotionUpdatesToQueue:motionUpdateQueue withHandler:^(CMDeviceMotion *motion, NSError *error){
                [self gatherMotion:motion andError:error];
            }];
            isReportingMotion = true;
        }
    }
    else {
        if (isReportingMotion == true) {
        [motionMan stopDeviceMotionUpdates];
        }
        isReportingMotion = false;
    }
}

- (void) gatherMotion:(CMDeviceMotion *)motion andError:(NSError*)err {
    if (err == nil) {
        [self parseAndReportMotion:motion];
    }
    else {
        NSLog(@"Error reading motion : %@", err);
        [self motionReporterShouldReport:false];
    }
}

// This method lets you pick what motion controls you want to control the parallax
// They each have slightly different behaviors, so pick the one that works the best for you
- (void) parseAndReportMotion:(CMDeviceMotion *)motion {
    
    //Pitch and roll motion
    {
//    cachePitch = motion.attitude.pitch;
//    cacheRoll = motion.attitude.roll;
//    NSLog(@"Pitch:%1.3f, Roll:%1.3f", motion.attitude.pitch, motion.attitude.roll);
    }
    
    //Quaternion based motion
    {
//    cachePitch = motion.attitude.quaternion.x;
//    cacheRoll = motion.attitude.quaternion.y;
//    NSLog(@"qX:%1.3f qY:%1.3f qZ:%1.3f qW:%1.3f", motion.attitude.quaternion.x, motion.attitude.quaternion.y, motion.attitude.quaternion.z, motion.attitude.quaternion.w);
    }
    
    //Gravity based motion
    {
    cachePitch = motion.gravity.y;
    cacheRoll = motion.gravity.x;
//    NSLog(@"Gr4vity:%1.3f, %1.3f, %1.3f", motion.gravity.x, motion.gravity.y, motion.gravity.z);
    }
    
    
    //These calculate your pitch based on whatever measurements you've enabled above
    calcPitch = (cachePitch-refPitch);// * 2;
    calcRoll = (cacheRoll-refRoll);// *2;
    //This notification lets the StackControllers know that we have new
    [notif postNotificationName:@"motionReported" object:nil];
}

// These optional methods reset your pitch and roll at 0 after a given time (defined in reference timer)
- (void) enableAutomaticReferencePointReset {
    NSTimer *referenceTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(orientToCurrentRotation) userInfo:nil repeats:YES];
    [referenceTimer fire];
}

// This method is fired by receiving the notification "resetFrame", and establishes a zero at the last cache
- (void) orientToCurrentRotation {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Old vals => pitch:%f, roll:%f", refPitch, refRoll);
        refPitch = cachePitch;
        refRoll = cacheRoll;
        NSLog(@"New vals => pitch:%f, roll:%f", refPitch, refRoll);
    });
}

@end
