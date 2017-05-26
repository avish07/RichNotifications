//
//  ViewController.m
//  Push
//
//  Created by gh on 5/10/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    globalVariable = @"use and change value where you want. It's really fascinating";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(IBAction)actionBtnTaaped:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = [btn tag];
    
    switch (tag) {
        case 0:
             [[AppDelegate delegate] initialseTimerNotificationData];
            break;
           
        default:
            break;
    }
   
}

@end
