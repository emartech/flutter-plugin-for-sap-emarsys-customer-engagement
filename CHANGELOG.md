# 1.1.0

## What's changed
[Emarsys SDK](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/)
* Updated underlying Emarsys SDK for Android to 3.2.0
* Updated underlying Emarsys SDK for iOS to 3.2.0
### [Predict](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#7-predict)
* Added new validation to the trackPurchase method so that empty cartItems lists are no longer accepted as it would be an invalid request. 
## What's fixed
### [Push](https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement/wiki#3-push) 
* Fixed an issue on both platforms, where in some cases app events where not fired when the app was not already running when the push message arrived.
* Fixed an issue on Android where the plug-in might not yet be initialized when the pushToken have been received causing the application to crash