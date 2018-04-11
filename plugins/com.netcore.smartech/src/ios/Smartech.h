//
//  Smartech.h
//  Smartech
//
//  Created by Admin on 10/04/18.
//

#import <Cordova/CDVViewController.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h>
#import <Cordova/CDVPlugin.h>

@interface Smartech : CDVPlugin

+(void)SmartechInitialize:(NSString *)applicationID withIdentity:(NSString *)identity;
+(void)execute:(NSString *)action withData:(NSMutableArray *)dataArray;


@end
