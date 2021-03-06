
[![Netcore Logo](https://netcore.in/wp-content/themes/netcore/img/Netcore-new-Logo.png)](http:www.netcore.in)

# Netcore iOS SDK
Smartech iOS SDK


## Integration using CocoaPod
1. Install CocoaPods on your computer.

2. Open your project and create pod file using below command
```swift
pod init
```
3. Add following line in your podfile
```swift
pod 'Netcore-Smartech-iOS-SDK'
```

4. Run following command in your project directory
```swift
pod install
```

5. Add Following capability inside your application
```swift
Push Notification
Background Mode -> Remote Notification
App Groups
```

6. Open App.xcworkspace and build.

## NetCore Manual Integration
1. Download iOS SDK and Unzip the file. Open Framework folder - inside it you will
see NetCorePush.framework file.
2. Open existing or create a new project in Xcode and drag drop or add framework
in Target > Embedded Binaries section
3. Add following frameworks inside your application if required
```swift
Security
CoreLocation
SystemConfiguration
JavaScriptCore 
```
4. Add Following capability inside your application
```swift
Push Notification
Background Mode -> Remote Notification
App Groups
```
5. Create Bridge file in existing swift project if required and add Following code inside file.
```objc
#import <NetCorePush/NetCorePush.h>
```

## NetCore SDK Initialization
1. Import following file in App Delegate File
```swift
import UserNotifications
import UserNotificationsUI
import NetCorePush
```
2. Add NetCore Application AppID in support in Finish Launching Methods
(AppDelegate file)
```swift
let appGroup = "<group.com.CompanyName.ProductName>"

NetCoreSharedManager.sharedInstance().setUpAppGroup(appGroup)

let netCore_AppID = "your App Id which you get from Netcore smartech admin panel"

NetCoreSharedManager.sharedInstance().handleApplicationLaunchEvent(launchOptions, forApplicationId: netCore_AppID)

//set up push delegate
NetCorePushTaskManager.sharedInstance().delegate = self
```
3. Register Device With NetCore SDK (AppDelegate file)
```swift
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

  //Identity must be “”(blank) or as per Primary key which defined on smartech Panel
  NetCoreInstallation.sharedInstance().netCorePushRegisteration(Identity, withDeviceToken: deviceToken) { (status) in }
}
```
## For Normal Push Notifications

```swift
//Handle Remote/Local Notification Delegate Events (AppDelegate file)
func application ( _ application : UIApplication, didReceiveRemoteNotification userInfo : [ AnyHashable : Any ]) {
  // perform notification received/click action as per third party SDK as per their document
  NetCorePushTaskManager.sharedInstance().didReceiveRemoteNotification(userInfo)
}

func application (_ application : UIApplication , didReceive notification : UILocalNotification ){
  NetCorePushTaskManager.sharedInstance().didReceiveLocalNotification(notification.userInfo)
}
```
```swift
// called when application is open when user click on notification
extension AppDelegate: UNUserNotificationCenterDelegate {

@objc (userNotificationCenter: didReceiveNotificationResponse :withCompletionHandler:)
@available ( iOS 10.0 , * )
func userNotificationCenter ( _ center : UNUserNotificationCenter, didReceive
response : UNNotificationResponse, withCompletionHandler completionHandler :
@escaping () -> Void ) {
  // perform notification received/click action as per third party SDK as per their document
  NetCorePushTaskManager.sharedInstance().userNotificationdidReceive(response)
  }
}
```

## To Handle URL Link

```swift
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
  if url.absoluteString.lowercased().contains ("your app URL link") {
    // handle URL link here
  }
  return true
}
```

## To Handle Deep Link

```swift
//For Handling deep link
extension AppDelegate : NetCorePushTaskManagerDelegate {
func handleNotificationOpenAction(_ userInfo: [AnyHashable : Any]!, deepLinkType strType: String!) {
  if strType .lowercased().contains ("your app deep link"){
    // handle deep link here
    }
  }
}
```
## To Handle Interactive buttons

```swift
func application(_ application: UIApplication, handleActionWithIdentifier identifier:
String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo
responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {

  NetCorePushTaskManager.sharedInstance().handleAction(withIdentifier: identifier, forRemoteNotification: userInfo,     withResponseInfo: responseInfo)
  completionHandler()

}
```

## For Login Activity
```swift
// Identity must be “”(blank) or as per Primary key which defined on smartech Panel
NetCoreInstallation.sharedInstance().netCorePushLogin(Identity) {(statusCode:Int) in }
```

## For Logout Activity
```swift
NetCoreInstallation.sharedInstance().netCorePushLogout { (statusCode:Int) in }
```
## For Profile Update
```swift
// Identity must be “”(blank) or as per Primary key which defined on smartech Panel
let info = ["NAME":"Tester", "AGE":"23", "MOBILE":"9898948849"]

NetCoreInstallation.sharedInstance().netCoreProfilePush(Identity, payload: info, block: nil)
//Attribute name must be in Capital such as NAME, AGE etc.

```
## To Track Custom Event
```swift
//add To cart event ID with custom array of data
NetCoreAppTracking.sharedInstance().sendEvent(withCustomPayload:Int(UInt32(tracking_AddToCart.rawValue)), payload: arrayAddToCart , block: nil)

//event name with custom payload dictionary of data
NetCoreAppTracking.sharedInstance()?.trackEvent(withCustomPayload: Event_Name,payload: payloadDict, block:nil)
eg.,
let payloadDict = NSMutableDictionary()
payloadDict.setValue("iPhonex", forKey: "name")
        
let array = Array(arrayLiteral: "1","2","3");
payloadDict.setValue(array, forKey: "Price")
        
let details = NSMutableDictionary()
details.setValue(“iphone XS", forKey: "name");
payloadDict.setValue(details, forKey: "details")

NetCoreAppTracking.sharedInstance()?.trackEvent(withCustomPayload: "Add to cart", payload: payloadDict, block:nil)
```
## To Fetch Delivered push notifications
```swift
let notificationArray : Array = NetCoreSharedManager.sharedInstance().getNotifications()

// To get recent 'n' number of notifications
let notificationArray : Array = NetCoreSharedManager.sharedInstance().getNotificationsWithCount(<count>)
```

## If user wants to opt out from being tracked
Add below code
```swift
NetCoreSharedManager.sharedInstance().optOut(<boolean_flag>)
```
Note:  The method mentioned above accepts a compulsory boolean value (true/false).


- If an end user wants to opt out, the flag should be passed as **true**. Once the user opts out, Netcore SDK will not be able to track that particular user further and no communications will be received by that user. </br>
**e.g. NetCoreSharedManager.sharedInstance().optOut(true)**

- If an end user wants to opt in, the flag should be passed as **false**. Once the user opts in, Netcore SDK will be able to track that particular user further and next communications will be received by that user.</br>
**e.g NetCoreSharedManager.sharedInstance().optOut(false)**

## To Set Identity
```swift
NetCoreSharedManager.sharedInstance()?.setUpIdentity(Identity)
// Identity must be “”(blank) or as per Primary key which defined on smartech Panel
```

## To Clear Identity
```swift
NetCoreSharedManager.sharedInstance()?.clearIdentity()
```
Note: The method clears the identity locally and all the event carried out after this call will be treated as Anonymous user activity.

## For Rich Push Notifications 
### Configuration Changes
```swift
1) Add “Notification Service Extension” to your app. File->New->Target- >Notification Service Extension.

2) Click Next and when asked to “Activate”, Click Activate.

3) Add “App Groups” to your apps Capabilities(Add one group with name "<group.com.CompanyName.ProductName>").

4) Enable App groups in Service Extension too and select group with name "<group.com.CompanyName.ProductName>".

5) If App group is not activated on the provisioning profile you are using, then 
i.Enable App groups in your provisioning profile from your Apple Developer’s account and replace the profile with the new one. Or,
ii.In your apps’s, Target->General-> Signing, Select “Automatically manage signing” and enable App groups by going to Target->Capabilities->App group. This will automatically add app groups capability to you provisioning profile.
```
***NOTE: For more clarity on this, please refer above <[SDK-Integration-Steps.pdf](https://github.com/NetcoreSolutions/Smartech-ios-sdk/blob/master/ObjectiveC-and-swift-Integration-Steps.pdf)>**

### Implementation Changes

Remove all the code written in “NotificationService” implementation class.

1) Import NetCore Framework into Extension
```swift
import NetCorePush
```
2) Handle Notification Request
```swift
override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    let appGroup = "<group.com.CompanyName.ProductName>"
    NetCoreNotificationService.sharedInstance().setUpAppGroup(appGroup)

    NetCoreNotificationService.sharedInstance().didReceive(request) { (contentToDeliver:UNNotificationContent) in
    contentHandler(contentToDeliver) 
  }
}
```
3) Handle Notification Service Time Expire
```swift
override func serviceExtensionTimeWillExpire() { 
  NetCoreNotificationService.sharedInstance().serviceExtensionTimeWillExpire() 
}

```
***NOTE: For more clarity on this, please refer above <[SDK-Integration-Steps.pdf](https://github.com/NetcoreSolutions/Smartech-ios-sdk/blob/master/ObjectiveC-and-swift-Integration-Steps.pdf)>**


## For Carousel Push Notifications 
### Configuration Changes
```swift
1) Add “Notification Content Extension” to your app. File->New->Target->Notification Content Extension.

2) Click Next and when asked to “Activate”, Click Activate.

3) Add “App Groups” to your apps Capabilities(Add one group with name "<group.com.CompanyName.ProductName>").

4) Enable “App Groups” in Content Extension too and select group with name "<group.com.CompanyName.ProductName>".

```
***NOTE: For more clarity on this, please refer above <[SDK-Integration-Steps.pdf](https://github.com/NetcoreSolutions/Smartech-ios-sdk/blob/master/ObjectiveC-and-swift-Integration-Steps.pdf)>**

### Implementation Changes
```swift
1) Replace “MainInterface.storyboard” of Content Extension with the one provided in "Rich Files".

2) In “Info.plist” file of Content Extension, replace “UNNotificationExtensionCategory” value with “SmartechPushCategory”.

3) In “Info.plist” file of Content Extension, add “UNNotificationExtensionDefaultContentHidden” Boolean value with “NO”.

4) Replace “NotificationViewController” class files from the "Rich Files" into your project.
```
***NOTE: For more clarity on this, please refer above <[SDK-Integration-Steps.pdf](https://github.com/NetcoreSolutions/Smartech-ios-sdk/blob/master/ObjectiveC-and-swift-Integration-Steps.pdf)>**

### Deployment Over Apple Store
Add Following runscript in your application target ,when you are deploying application
over apple store,this run script use remove unused architecture in release mode
```swift
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

EXTRACTED_ARCHS=()

for ARCH in $ARCHS
do
echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
done

echo "Merging extracted architectures: ${ARCHS}"
lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
rm "${EXTRACTED_ARCHS[@]}"

echo "Replacing original executable with thinned version"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

done
```

