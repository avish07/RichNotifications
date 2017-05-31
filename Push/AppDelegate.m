//
//  AppDelegate.m
//  Push
//
//  Created by gh on 5/10/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "NotificationService.h"

NSString *const pushNotificationCategoryIdent = @"Actionable";
NSString *const pushNotificationFirstActionIdent = @"First_Action";
NSString *const pushNotificationSecondActionIdent = @"Second_Action";

@interface AppDelegate (){
    NSString *devceToken;
    UNUserNotificationCenter *center;
}

@end

NSString * globalVariable;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self registerForLocalNotification];
    
    UILocalNotification *launchNote = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (launchNote) {
        
        NSLog(@":%@", launchNote.userInfo);
        
        
    }
    return YES;
}


// Local Notifications

-(void)registerForLocalNotification{
    center = [UNUserNotificationCenter currentNotificationCenter];
    [center setDelegate:self];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *  settings) {
       
        if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined || settings.authorizationStatus == UNAuthorizationStatusDenied) {
      
        [center requestAuthorizationWithOptions:UNAuthorizationOptionSound + UNAuthorizationOptionBadge + UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError *  error) {
            if (!granted) {
                NSLog(@"something went wrong");
            }
            else
            {
                
            }
        }];
        }
    }];
    
}

-(void)initialseTimerNotificationData{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Rich Notificaions";
    content.subtitle = @"implemented in iOS 10";
    content.body = @"This also includes support for Multiple Targets. It's a fascinating thing.";
    content.sound = [UNNotificationSound defaultSound];
    //content.badge = @1;
    content.accessibilityHint = @"NotificationCategory1";
    
    NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"notification" withExtension:@"png"];
    NSError *attachmentError = nil;
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"" URL:imgUrl options:@{UNNotificationAttachmentOptionsTypeHintKey: @"kUTTypePNG"} error:&attachmentError];
    content.attachments = @[attachment];
    
    [self addNotificationAction];
    
    // category identifier should be unique. As diff
    content.categoryIdentifier = @"NotificationCategory1";
   
    
    // convert string to date
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60];
    NSDateComponents *componenets = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond + NSCalendarUnitNanosecond fromDate:date];
    
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:componenets repeats:false];
    
    
   // [UIApplication sharedApplication].applicationIconBadgeNumber++;
    
    // scheduling a notification
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Timer" content:content trigger:trigger];

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        if (error) {
            NSLog(@":%@", error.localizedDescription);
        }
        
    }];
}


-(void)addNotificationAction{
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"Delete" title:@"Delete" options:UNNotificationActionOptionDestructive];
    UNNotificationAction *openAction = [UNNotificationAction actionWithIdentifier:@"Open" title:@"Open" options:UNNotificationActionOptionForeground];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"NotificationCategory1" actions:@[deleteAction, openAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    NSSet *Categories = [NSSet setWithObject:category];
    
    [center setNotificationCategories: Categories];
    
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
   // [UIApplication sharedApplication].applicationIconBadgeNumber++;

    
    NSLog(@":%@", response.notification.request.content.categoryIdentifier);
    
    if ([response.notification.request.content.categoryIdentifier isEqualToString:@"NotificationCategory1"]) {
        if (response.actionIdentifier == UNNotificationDismissActionIdentifier) {
            NSLog(@"action");
        }
        else if ([response.actionIdentifier  isEqual: @"Delete"]){
            
            NSLog(@"Delete");
        }
        else if ([response.actionIdentifier isEqual: @"Open"]){
            NSLog(@"open");
        }
    }
    
    completionHandler();
    
}

-(void)setTriggerTime{
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:100 repeats:YES];
}

-(void)setTriggerForCalendar{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:100];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear + NSCalendarUnitMonth + NSCalendarUnitDay + NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond fromDate:date];
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:YES];
}


- (void)registerForRemoteNotification
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
         center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            //[[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) categories:nil]];
        }];
    }
    else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}


-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"error here : %@", error);//not called
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    devceToken = [[NSString alloc]initWithFormat:@"%@",[[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSLog(@"Device Token = %@",devceToken);
    
    [self registerForActionablePushNotification];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=  10.0) {
        [self application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult result){}];
    } else {
        /// previous stuffs for iOS 9 and below. I've shown an alert wth received data.
    }
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    //Called when a notification is delivered to a foreground app.
    
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    completionHandler(UNNotificationPresentationOptionAlert);
}




-(void)removeNotifications{
    [center removeAllDeliveredNotifications];
    [center removeAllPendingNotificationRequests];
}


-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler {

    NSLog(@"info: %@", userInfo);
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        
    }
    
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        NSLog( @"INACTIVE" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        NSLog( @"BACKGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
    else
    {
        NSLog( @"FOREGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
    
}


// for Actionable push notification

-(void)registerForActionablePushNotification{
    
    UIMutableUserNotificationAction *firstAction = [[UIMutableUserNotificationAction alloc] init];
    [firstAction setActivationMode:UIUserNotificationActivationModeBackground];
    [firstAction setTitle:@"First Action"];
    [firstAction setIdentifier: pushNotificationFirstActionIdent];
    [firstAction setDestructive:NO];
    [firstAction setAuthenticationRequired:NO];
    
    UIMutableUserNotificationAction *secondAction = [[UIMutableUserNotificationAction alloc] init];
    [secondAction setActivationMode:UIUserNotificationActivationModeBackground];
    [secondAction setTitle:@"Second Action"];
    [secondAction setIdentifier: pushNotificationSecondActionIdent];
    [secondAction setAuthenticationRequired:NO];
    
    UIMutableUserNotificationCategory *pushNotificationCategory = [[UIMutableUserNotificationCategory alloc] init];
    [pushNotificationCategory setIdentifier:pushNotificationCategoryIdent];
    [pushNotificationCategory setActions: @[firstAction, secondAction] forContext:UIUserNotificationActionContextDefault];
    
    NSSet *pushNotficationCategories = [NSSet setWithObject:pushNotificationCategory];
    UIUserNotificationType types = (UIUserNotificationTypeSound| UIUserNotificationTypeAlert| UIUserNotificationTypeBadge);
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:pushNotficationCategories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler{
    
    if ([identifier isEqualToString:pushNotificationFirstActionIdent]) {
        
        NSLog(@"Action 1");
        
    }else if ([identifier isEqualToString:pushNotificationSecondActionIdent]){
        
        NSLog(@"Action 2");
        
    }
    
    if (completionHandler) {
        completionHandler();
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    application.applicationIconBadgeNumber = 0;
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    
}

+(AppDelegate *)delegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end
