# 1.2.3
## What's fixed
[Inline In-App](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#42-inline-in-app)
* Fixed crash when an Inline In-App was fetched with a wrong viewId

# 1.2.2

## What's changed
[Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying Emarsys SDK for Android to 3.2.1
* Updated underlying Emarsys SDK for iOS to 3.2.1

# 1.2.1
## What's fixed
[UserNotificationCenterDelegateCacher](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/blob/master/ios/Classes/Wrapper/Push/UserNotificationCenterDelegateCacher.swift)
* Made UserNotificationCenterDelegateCacher instance public

# 1.2.0

## What's changed
[UserNotificationCenterDelegateCacher](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/blob/master/ios/Classes/Wrapper/Push/UserNotificationCenterDelegateCacher.swift)
* Made UserNotificationCenterDelegateCacher public to be available

# 1.1.0

## What's changed
[Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
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