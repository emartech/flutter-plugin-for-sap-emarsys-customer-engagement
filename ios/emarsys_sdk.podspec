#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint emarsys_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'emarsys_sdk'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plug-in for SAP Emarsys Customer Engagement'
  s.description      = <<-DESC
This is the iOS native part of the Flutter plug-in for SAP Emarsys Customer Engagement which is the official plug-in to help integrate Emarsys into your Flutter application. 
                       DESC
  s.homepage         = 'https://github.com/emartech/flutter-plugin-for-sap-emarsys-customer-engagement'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Emarsys' => 'sdk-team@emarsys.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'EmarsysSDK','~> 3.0.3'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
