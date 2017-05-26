//
//  NotificationViewController.m
//  NotificationViewC
//
//  Created by gh on 5/11/17.
//  Copyright © 2017 Slack. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property IBOutlet UIImageView *picUrl;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    
    
    NSDictionary *dict = notification.request.content.userInfo;
    
    for (UNNotificationAttachment *attachment in notification.request.content.attachments) {
        
        if (dict[@"attachment-url"] && [attachment.identifier
                                        isEqualToString:[[dict objectForKey:@"attachment-url"] lastPathComponent]]) {
            if ([attachment.URL startAccessingSecurityScopedResource])
            {
                NSData *imageData = [NSData dataWithContentsOfURL:attachment.URL];
                
                _picUrl.image = [UIImage imageWithData:imageData];
                
                // This is done if the spread url is not downloaded then both the image view will show cover url.
                _picUrl.image = [UIImage imageWithData:imageData];
                [attachment.URL stopAccessingSecurityScopedResource];
            }
        }
    }
    
}

@end
