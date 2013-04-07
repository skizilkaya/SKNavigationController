//
//  ViewController.m
//  SKNavigationControllerProject
//
//  Created by Selçuk Kızılkaya on 4/4/13.
//  Copyright (c) 2013 Selçuk Kızılkaya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%200/255.0 green:arc4random()%150/255.0 blue:arc4random()%100/255.0 alpha:1];
    button.frame = CGRectMake(arc4random() % 60, arc4random() % 40, arc4random() % 100 + 90, arc4random() % 40+ 80);
    lbl.text = [NSString stringWithFormat:@"%d",[self.navigationController.viewControllers count]];
}
- (IBAction)selector:(id)sender {
    ViewController * v = [[[ViewController alloc] init] autorelease];
    [self.navigationController pushViewController:v animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
