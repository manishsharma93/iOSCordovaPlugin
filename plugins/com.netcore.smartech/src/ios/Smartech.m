//
//  Smartech.m
//  Smartech
//
//  Created by Admin on 10/04/18.
//

#import "Smartech.h"
#import <NetCorePush/NetCorePush.h>

@implementation Smartech

//+(void)load {
//
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
////
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onHandleRegisterForRemoteNotification:) name:@"" object:nil];
//
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Manish" message:@"Hello world!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil
//                          , nil];
//    [alert show];
//
//}
//
//-(void)pluginInitialize {
//    [super pluginInitialize];
//
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onHandleOpenURLNotification:) name: @"" object:nil];
////
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onHandleNotification:) name:@"" object:nil];
//
//    NSLog(@"pluginInitialize");
//
//}
//
//-(void)notifyDeviceReady:(CDVInvokedUrlCommand *)command {
//    
//}

+(void)SmartechInitialize:(NSString *)applicationID withIdentity:(NSString *)identity{
    
    [[NetCoreSharedManager sharedInstance] setUpApplicationId:applicationID];
    [[NetCoreSharedManager sharedInstance] setUpIdentity:identity];
    
}

+(void)execute:(NSString *)action withData:(NSMutableArray *)dataArray{
    if (([action isEqualToString:@"track"]) && (dataArray.count > 0)){
        
        NSString *event = dataArray.firstObject[@"eventId"];
        NSInteger eventID = event.integerValue;
        NSString *identity = @"";
        
        NSLog(@"%ld",(long)eventID);
        
        if ([dataArray.firstObject containsObject:@"identity"]) {
            identity = dataArray.firstObject[@"identity"];
        }
        
        [[NetCoreSharedManager sharedInstance] setUpIdentity:identity];
        
        switch (eventID) {
            case 0:
                if ([dataArray.firstObject containsObject:@"profile"]) {
                    NSDictionary *profileDict = dataArray.firstObject[@"profile"];
                    [[NetCoreInstallation sharedInstance] netCoreProfilePush:identity Payload:profileDict Block:^(NSInteger statusCode) {
                    }];
                }
                break;
                
            case 22:
                [[NetCoreInstallation sharedInstance] netCorePushLogin:identity Block:^(NSInteger statusCode) {
                }];
                break;
                
            case 23:
                [[NetCoreInstallation sharedInstance] netCorePushLogout:^(NSInteger statusCode) {
                }];
                break;
                
            case 25:
                if ([dataArray.firstObject containsObject:@"applicationId"]) {
                    NSString *applicationID = dataArray.firstObject[@"applicationId"];
                    [[NetCoreSharedManager sharedInstance] handleApplicationLaunchEvent:nil forApplicationId:applicationID];
                    //                    [[NetCoreSharedManager sharedInstance] setUpApplicationId:applicationID];
                }
                break;
                
            default:
                if ([dataArray.firstObject containsObject:@"payload"]) {
                    NSMutableArray *payloadArray = dataArray.firstObject[@"payload"];
                    
                    [[NetCoreAppTracking sharedInstance] sendAppTrackingEventWithCustomPayload:eventID Payload:payloadArray Block:^(NSInteger statusCode) {
                    }];
                }
                
                break;
        }
        
    } else {
        NSLog(@"Activity Id is not passed");
        
    }
}

@end
