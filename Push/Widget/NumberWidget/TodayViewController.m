//
//  TodayViewController.m
//  NumberWidget
//
//  Created by Dhruv Sharma on 09/11/16.
//  Copyright © 2016 Avish Manocha. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
-(IBAction)actionTapped:(id)sender;
@end

@implementation TodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDefaultsDidChange:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    [self updateNumberLabelText];
    // Do any additional setup after loading the view from its nib.
}


-(void)dealloc{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    // self.numberLabel.text = [NSString stringWithFormat:@"%@", @49];
    
    self.preferredContentSize = CGSizeMake(320, 170);
    completionHandler(NCUpdateResultNewData);
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateNumberLabelText];
}

- (void)updateNumberLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.Guesthouser.w"];
    NSInteger number = [defaults integerForKey:@"sharedInteger"];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)number];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.numberLabel.text = [NSString stringWithFormat:@"%@", @29];

    NSLog(@"touch");
}


-(IBAction)open:(id)sender{
    
    NSURL *url = [NSURL URLWithString:@"w:"];

    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
    
    
    
    }];
}

@end
