//
//  ViewController.m
//  W
//
//  Created by Dhruv Sharma on 09/11/16.
//  Copyright © 2016 Avish Manocha. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (isaa) {
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)actionBtnTapped:(id)sender{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.Guesthouser.w"];
    [userDefaults setInteger:[tf.text integerValue] forKey:@"sharedInteger"];
    [userDefaults synchronize];
}
@end
