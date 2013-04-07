//
//  SKNavigationController.h
//  SKNavigationControllerProject
//
//  Created by Selçuk Kızılkaya on 4/4/13.
//  Copyright (c) 2013 Selçuk Kızılkaya. All rights reserved.
//  slckkzlky@gmail.com

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SKNavigationHistoryBar.h"
#import "UIView+SKAnimate.h"

@interface SKNavigationController : UINavigationController {
    SKNavigationHistoryBar * _historyBar;
    int                      _height;
}
- (void) closeHistoryBar;
- (void) backButtonPressedLong:(id) sender;
- (void) backButtonPressed:(id) sender;
@end
