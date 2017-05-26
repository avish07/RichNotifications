//
//  AppDelegate.h
//  Push
//
//  Created by gh on 5/10/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

extern NSString * globalVariable;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate *)delegate;
-(void)initialseTimerNotificationData;

@end

