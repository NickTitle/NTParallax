//
//  AppDelegate.h
//  NTParallax
//
//  Created by Nick Esposito on 7/9/13.
//  Copyright (c) 2013 NickTitle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTMotionReporter.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NTMotionReporter *mR;

@end
