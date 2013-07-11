//
//  NTMotionReporter.h
//  NTParallax
//
//  Created by Nick Esposito on 7/9/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface NTMotionReporter : NSObject

+(NTMotionReporter *)singleReporter;

@property (strong, nonatomic) CMMotionManager *motionMan;
@property (strong, nonatomic) NSOperationQueue *motionUpdateQueue;
@property (nonatomic, assign) double rawPitch;
@property (nonatomic, assign) double rawRoll;
@property (nonatomic, assign) double calcPitch;
@property (nonatomic, assign) double calcRoll;

- (void) motionReporterShouldReport:(BOOL)reportBool;

@end
