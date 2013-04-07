//
//  SKNavigationController.m
//  SKNavigationControllerProject
//
//  Created by Selçuk Kızılkaya on 4/4/13.
//  Copyright (c) 2013 Selçuk Kızılkaya. All rights reserved.
//  slckkzlky@gmail.com

#import "SKNavigationController.h"

@interface SKNavigationController ()

@end

@implementation SKNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _height = 150;

    }
    return self;
}
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([self.viewControllers count] > 0) {
        [self setBackButtonForViewController:viewController];
    }

    [self closeHistoryBar];
    [super pushViewController:viewController animated:YES];
}



- (void) setBackButtonForViewController:(UIViewController *) viewController {
    
    
    
    UIImage *leftArrowImage;
    UIImage *pressedLeftArrowImage;
    UIButton *customBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    [customBackButton setAutoresizingMask:UIViewAutoresizingNone];
    customBackButton.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    [customBackButton setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [customBackButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [customBackButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        leftArrowImage = [UIImage imageNamed:@"UINavigationBarSilverBack.png"];
        pressedLeftArrowImage = [UIImage imageNamed:@"UINavigationBarSilverBackPressed.png"];
    }
    else {
        leftArrowImage = [UIImage imageNamed:@"UINavigationBarDefaultBack.png"];
        pressedLeftArrowImage = [UIImage imageNamed:@"UINavigationBarDefaultBackPressed.png"];
    }
    UIImage *stretchableLeftArrowImage = [leftArrowImage stretchableImageWithLeftCapWidth:15.0 topCapHeight:0];
    UIImage *stretchablePressedLeftArrowImage = [pressedLeftArrowImage stretchableImageWithLeftCapWidth:15.0 topCapHeight:0];
    [customBackButton setBackgroundColor:[UIColor clearColor]];
    [customBackButton setBackgroundImage:stretchableLeftArrowImage forState:UIControlStateNormal];
    [customBackButton setBackgroundImage:stretchablePressedLeftArrowImage forState:UIControlStateHighlighted];
    
    [customBackButton addGestureRecognizer:[[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonPressedLong:)] autorelease]];
    [customBackButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *aCustomBackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customBackButton];
    [[viewController navigationItem] setLeftBarButtonItem:aCustomBackButtonItem];
}

- (void) backButtonPressedLong:(id) sender {
    if ( [sender state] != UIGestureRecognizerStateBegan )
        return;
    
    if (!_historyBar) {
        
        int padding = [self padding:YES];
        
        for (UIView * view in self.view.subviews) {
            if (![view isKindOfClass:[UINavigationBar class]]) {
                [view animateWithRect:CGRectMake(view.frame.origin.x, _height + view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            }
        }
        
        _historyBar = [[SKNavigationHistoryBar alloc] initWithFrame:CGRectMake(0, -_height + padding, [self widthForOrientation], _height) nController:self];
        [_historyBar setUserInteractionEnabled:YES];
        [self.view addSubview:_historyBar];
        [self.view bringSubviewToFront:self.navigationBar];
        [_historyBar animateWithRect:CGRectMake(0, padding, [self widthForOrientation], _height)];
        [_historyBar release];
        
        
    } else {
        [self closeHistoryBar];
    }
}
- (void) backButtonPressed:(id) sender {
    [self popViewControllerAnimated:YES];
    [self closeHistoryBar];
}

- (void) closeHistoryBar {
    if (_historyBar) {
        for (UIView * view in self.view.subviews) {
            if (![view isKindOfClass:[UINavigationBar class]])
                [view animateWithRect:CGRectMake(view.frame.origin.x, view.frame.origin.y - _height, view.frame.size.width, view.frame.size.height)];
        }
        [_historyBar removeFromSuperview];
        _historyBar = nil;
    }
}

- (CGFloat) widthForOrientation {
    UIInterfaceOrientation current = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(current)) {
        return [UIScreen mainScreen].bounds.size.width;
    } else if (UIInterfaceOrientationIsLandscape(current)) {
        return [UIScreen mainScreen].bounds.size.height;
    }
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat) padding:(BOOL) control {
    UIInterfaceOrientation current = [UIApplication sharedApplication].statusBarOrientation;
    int padding = ([UIApplication sharedApplication].statusBarHidden)?0:20;
    int navBarHeight = 0;
    
    if (control) {
        if (UIInterfaceOrientationIsPortrait(current)) {
            navBarHeight = 44;
        } else if (UIInterfaceOrientationIsLandscape(current)) {
            navBarHeight = 32;
        }
    } else {
        if (UIInterfaceOrientationIsPortrait(current)) {
            navBarHeight = 32;
        } else if (UIInterfaceOrientationIsLandscape(current)) {
            navBarHeight = 44;
        }
    }

    
    padding += (self.navigationBarHidden)?0:navBarHeight;
    
    return padding;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    int padding = [self padding:NO];
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        if (_historyBar) {
            [_historyBar changeInterfaceOrientation:CGRectMake(0, padding, [UIScreen mainScreen].bounds.size.width, _height)];
        }
    }
    else if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        if (_historyBar)
            [_historyBar changeInterfaceOrientation:CGRectMake(0, padding, [UIScreen mainScreen].bounds.size.height, _height)];
    }
}



@end
