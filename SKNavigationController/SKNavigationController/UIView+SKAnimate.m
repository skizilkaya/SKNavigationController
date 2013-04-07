//
//  UIView+GBAnimate.m
//  MyJiraClient
//
//  Created by Selçuk Kızılkaya on 1/29/13.
//  Copyright (c) 2013 Selçuk Kızılkaya. All rights reserved.
//  slckkzlky@gmail.com

#import "UIView+SKAnimate.h"

@implementation UIView (SKAnimate)


- (void) animateWithRect:(CGRect) rect {
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = rect;
                     }
                     completion:^(BOOL finished){
                     }];
}


@end
