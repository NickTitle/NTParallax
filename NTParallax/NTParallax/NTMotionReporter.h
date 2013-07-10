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

@end
