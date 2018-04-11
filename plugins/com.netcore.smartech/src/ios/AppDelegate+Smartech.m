//
//  AppDelegate+Smartech.m
//  Smartech
//
//  Created by Admin on 10/04/18.
//

#import "AppDelegate+Smartech.h"

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end
#endif

@implementation AppDelegate_Smartech

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:launchOptions];
    
    return TRUE;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:deviceToken];
}

- (void)application:(UIApplication*)application
didReceiveRemoteNotification:(NSDictionary*)userInfo {
//    [[NetCorePushTaskManager sharedInstance] didReceiveRemoteNotification:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:userInfo];

}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    [[NetCorePushTaskManager sharedInstance] didReceiveLocalNotification:notification.userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:notification.userInfo];

}

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:notification.request.content.userInfo];
}
#endif

@end
