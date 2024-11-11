# 2.5.2
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.11) for Android to 3.7.11
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.7.3) for iOS to 3.7.3

# 2.5.1
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.10) for Android to 3.7.10
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.7.2) for iOS to 3.7.2

# 2.5.0
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.7) for Android to 3.7.7
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.7.0) for iOS to 3.7.0

# 2.4.0
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.6) for Android to 3.7.6
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.6.0) for iOS to 3.6.0
* We bumped our minimum supported iOS version to 14 to be able to use newer network change detection solution.
## What's fixed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* @UIApplicationMain annotation was removed from the EmarsysAppDelegate because the inheriting AppDelegate has to use it.

# 2.3.3
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.5) for Android to 3.7.5
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.5.1) for iOS to 3.5.1
## What's fixed
### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push)
* Fixed the initialization of the SDK when the app is started by a push.

# 2.3.2
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.4) for Android to 3.7.4
## What's fixed
### [Predict](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#7-predict)
* Fixed the mapping of the predict recommendation filters on iOS
* Fixed the mapping of the predict cart items on both platforms

# 2.3.1
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.3) for Android to 3.7.3

# 2.3.0
## What's changed
### [Android SDK](https://github.com/emartech/android-emarsys-sdk/)
* Fixed an issue that caused push notifications not to be shown.
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* On Android we increased CompileSDKVersion to 34.
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.2) for Android to 3.7.2
## What's fixed
### [Android SDK](https://github.com/emartech/android-emarsys-sdk/)
* Fixed an issue that could cause a crash because of some unhandled exceptions.

# 2.2.0
## What's changed
### [Android SDK](https://github.com/emartech/android-emarsys-sdk/)
* Remove JVM Toolchain Specification for Better M1 Compatibility
### [iOS SDK](https://github.com/emartech/ios-emarsys-sdk/)
* Minimum iOS version was increased to 12.0
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Increased minimun Dart version from 2.14.0 to 2.15.0
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.7.0) for Android to 3.7.0
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.5.0) for iOS to 3.5.0

# 2.1.0
## What's new
### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push)
* Introduced a new function in EmarsysAppDelegate where UNUserNotificationDelegates can be provided. For usage see the example app's AppDelegate.

# 2.0.0
## What's changed
### [Emarsys](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#12-setup-the-emarsys-sdk)
* The underlying AGP plugin has been updated to 8.1.1 therefore breaking changes in that plugin are now surfacing for existing integrations. Please check the linked documentations on how to migrate.
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.6.2) for Android to 3.6.2
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.4.2) for iOS to 3.4.2

# 1.6.5
## What's fixed
### [Geofence](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#6-geofence)
* initialEnterTriggerEnabled command creation has been fixed for iOS platform

# 1.6.4
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.4.1) for iOS to 3.4.1

# 1.6.3
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.4.0) for iOS to 3.4.0
## What's fixed
 ### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push) 
* Fixed a issue that caused the isCanBypassDnd to be a null value in the notification settings on Android

# 1.6.2
## What's new
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.5.3) for Android to 3.5.3
## What's fixed
 ### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push) 
* Fixed an issue that caused App Events being missed in case the App start was triggered by a push message.

# 1.6.1
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.5.1) for Android to 3.5.1
* Updated underlying [Emarsys SDK](https://github.com/emartech/ios-emarsys-sdk/releases/tag/3.3.1) for iOS to 3.3.1
# 1.6.0
# What's fixed
### [Android SDK](https://github.com/emartech/android-emarsys-sdk/wiki#3-inapp)
* Fixed an issue that could cause the SDK to crash during In-App appearing.
# What's changed
### [Android SDK](https://github.com/emartech/android-emarsys-sdk/wiki#2-push)
* Push Internal ID now supports string.
# 1.5.0
# What's new
### [InApp](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#4-in-app)
* SDK now supports CopyToClipboard action in inapp messages.
# What's fixed
### [Android SDK](https://github.com/emartech/android-emarsys-sdk/wiki)
* Fixed an issue that could cause the SDK to crash because of rare race conditions in the database.
# What's changed
### [ChangeAppcode](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#21-changeapplicationcode)
* Prevent SDK from unnecessary network calls when an invalid `applicationCode` was set.
# 1.4.0
## What's new
### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push)
* Introduce setPushToken method what can be used for setting the pushToken when not the [automatic / recommended](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#31-pushsendingenabled) way is used
# 1.3.3
## What's fixed
### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push)
* Fixed issue where notifications didn't arrive when application was not running
# 1.3.2
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.2.6) for Android to 3.2.6
* This version is Android 13 and iOS 16 compatible
# 1.3.1
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying [Emarsys SDK](https://github.com/emartech/android-emarsys-sdk/releases/tag/3.2.5) for Android to 3.2.5
# 1.3.0
## What's new
### [Inline In-App](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#42-inline-in-app)
* Added support for Inline in-app views on Flutter version 3.0 and above
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying Emarsys SDK for Android to 3.2.4
* Updated underlying Emarsys SDK for iOS to 3.2.3
# 1.2.3
## What's fixed
### [Inline In-App](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#42-inline-in-app)
* Fixed crash when an Inline In-App was fetched with a wrong viewId
## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying Emarsys SDK for Android to 3.2.2
* Updated underlying Emarsys SDK for iOS to 3.2.2

# 1.2.2

## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying Emarsys SDK for Android to 3.2.1
* Updated underlying Emarsys SDK for iOS to 3.2.1

# 1.2.1
## What's fixed
### [UserNotificationCenterDelegateCacher](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/blob/master/ios/Classes/Wrapper/Push/UserNotificationCenterDelegateCacher.swift)
* Made UserNotificationCenterDelegateCacher instance public

# 1.2.0

## What's changed
### [UserNotificationCenterDelegateCacher](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/blob/master/ios/Classes/Wrapper/Push/UserNotificationCenterDelegateCacher.swift)
* Made UserNotificationCenterDelegateCacher public to be available

# 1.1.0

## What's changed
### [Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying Emarsys SDK for Android to 3.2.0
* Updated underlying Emarsys SDK for iOS to 3.2.0
### [Predict](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#7-predict)
* Added new validation to the trackPurchase method so that empty cartItems lists are no longer accepted as it would be an invalid request. 
## What's fixed
### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push) 
* Fixed an issue on both platforms, where in some cases app events where not fired when the app was not already running when the push message arrived.
* Fixed an issue on Android where the plug-in might not yet be initialized when the pushToken have been received causing the application to crash

# 1.0.0
## What's new
### Native SDK
* Migrated plug-in to use SDK 3.1.1 version on both platforms.
### [Predict](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#7-predict) 
* Added support for Predict feature, both recommendation and tracking works.
### [Geofence](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#67-registeredgeofences) 
* Registered geofences can now be accessed.
## Important Notes
> `Flutter plug-in for SAP Emarsys Customer Engagement` is still under development. If you would like to use the plug-in please contact your CSM @ Emarsys.

# 0.3.0
## What's new
### Native SDK
* Migrated plug-in to use Android SDK 3.1.1
### [Inline In-App](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#42-inline-in-app) 
* Added support for the inline In-App feature.
## What's fixed
### Push
* Fixed an issue on Android, where if the application has been closed after the push notification had been displayed then interaction with the push message caused the application to crash.
### Setup
* Fixed an issue on Android, where the first activity was displayed sooner than the SDK setup has been completed causing some app-start-related events to be ignored by the SDK.
* Fixed an issue on Android, where verbose logging caused some inside crashes in the SDK.

## Important Notes
> `Flutter plug-in for SAP Emarsys Customer Engagement` is still under development and some Emarsys features are not yet supported by the plug-in. If you would like to use the plug-in please contact your CSM @ Emarsys.
> This version contains all the fixes from the native SDKs.

# 0.2.0
## What's new
### Native SDK
* Migrated plug-in to use Android SDK 3.0.1 and iOS SDK 3.0.3.
### [changeApplicationCode](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#21-changeapplicationcode) 
* Added changeApplicationCode feature
### [trackCustomEvent](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#15-trackcustomevent)
* Added trackCustomEvent feature
### [Inbox](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#5-inbox)
* Added inbox feature
### [Geofence](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#6-geofence)
* Added geofence feature
### [Overlay In-App](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#41-overlay-in-app)
* Added Overlay In-App feature

## What's fixed
### Push
* Fixed an issue on iOS, where push messages didn't arrive when the app was in the foreground.
* Fixed an issue on Android, where the application crashed while it was not running and it received a push message.

## Important Notes
> `Flutter plug-in for SAP Emarsys Customer Engagement` is still under development and some Emarsys features are not yet supported by the plug-in. If you would like to use the plug-in please contact your CSM @ Emarsys.
> This version contains all the fixes from the native SDKs.

# 0.1.1

## What's new
### Native SDK
* Migrated plug-in to use Android and iOS SDK version from 2.16.0 to 3.0.0.
## What's fixed
### Setup
* Fixed an issue on iOS, where push messages do not arrive in case of delayed setup.

## Important Notes
> `Flutter plug-in for SAP Emarsys Customer Engagement` is still under development and some Emarsys features are not yet supported by the plug-in. If you would like to use the plug-in please contact your CSM @ Emarsys.
> This version contains all the fixes from the native SDK's from 2.16.0 to 3.0.0.

# 0.1.0

## What's new
### [Flutter](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement)
* [Currently supported features](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki):
  * [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#push):
    * Rich push 
    * Push Actions
    * Push event handlers
    * Silent Push
  * [Config](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-config)
  * In-App display when the user starts the App

## Important Notes
> `Flutter plug-in for SAP Emarsys Customer Engagement` is still under development and some Emarsys features are not yet supported by the plug-in. If you would like to use the plug-in please contact your CSM @ Emarsys.