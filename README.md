# RichNotifications

RichNotifications are very Fascinating feature in iOS 10. It has :-


1. Push Rich notification
 . Use service extension(Notification Service extension) for default view and use Notification Content extension for make custom notification view.
 . Make sure that notification payload contains: mutable-content = 1 in the aps dictionary.
 . this contains all types of fun like Image, GIF, Audio, Video.
 . Make sure that Image <= 10 MB, Audio <= 5 MB, Video <= 50 MB.
 . for silent notiifcations Make sure that notification payload contains: mutable-content = 1 in the aps dictionary. Also Payload does n't contain Alert/Badge/Sound.
 . Make Actionable Notiifciations by using Category.

2. Local Notifications
 . Use UNMutableNotificationContent for make notification.
 . schedule notification using UNCalendarNotification trigger, UNTimeIntervalNotificationTrigger.
 . Make Actionable Notiifciations by using Category.
 
 
 P.S. - Make sure that Actionable Notiification identifier should be identical. Put your bundle identifier and develpoment team in General Tab.
