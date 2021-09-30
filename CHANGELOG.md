# 0.3.0
## What's new
### Native SDK
* Migrated plug-in to use Android SDK 3.1.1
### [Inline In-App](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#42-inline-in-app) 
* Added support for inline In-App feature.
## What's fixed
### Push
* Fixed an issue on Android, where if the application has been closed after the push notification had been displayed then interaction with the push message caused the application to crash.
### Setup
* Fixed an issue on Android, where the first activity was displayed sooner than the SDK setup has been completed causing some app-start related events to be ignored by the SDK.
* Fixed an issue on Android, where verbose logging caused some inside crashes in the SDK.

## Important Notes
> `Flutter plug-in for SAP Emarsys Customer Engagement` is still under development and some Emarsys features are not yet supported by the plug-in. If you would like to use the plug-in please contact your CSM @ Emarsys.
> This version contains all the fixes from the native SDKs.