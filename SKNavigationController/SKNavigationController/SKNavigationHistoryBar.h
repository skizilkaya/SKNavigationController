//
//  SKNavigationHistoryBar.h
//  SKNavigationControllerProject
//
//  Created by Selçuk Kızılkaya on 4/4/13.
//  Copyright (c) 2013 Selçuk Kızılkaya. All rights reserved.
//  slckkzlky@gmail.com

#import <UIKit/UIKit.h>
#include <QuartzCore/QuartzCore.h>

@class SKNavigationController;

@interface SKNavigationHistoryBar : UIView<UIGestureRecognizerDelegate> {
    
    SKNavigationController *    _navigationController;
    UIScrollView *              _scrollView;
    CGFloat                     _contentSize;
	CGFloat                     _X;
	CGFloat                     _Y;

}

@property(nonatomic,retain) SKNavigationController * navigationController;

- (id)initWithFrame:(CGRect)frame nController:(SKNavigationController *) nController;

- (void)                     changeInterfaceOrientation:(CGRect) rect;
- (void)                     renderUI;
- (void)                     swapViews:(NSInteger) tag;
- (void)                     panGestureRecognizer:(UIPanGestureRecognizer *) sender;
- (void)                     imageTapped:(UITapGestureRecognizer *) sender;
- (void)                     removeViewControllerWithTag:(NSInteger) tag;
- (UIImageView *)            createImageViewForViewController:(UIViewController *) viewController tag:(NSInteger) tag;
- (UIImage *)                captureScreenInRect:(UIView *) view;
- (UIPanGestureRecognizer *) panGestureRecognizer;

@end
