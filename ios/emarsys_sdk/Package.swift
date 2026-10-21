// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "emarsys_sdk",
    platforms: [
        .iOS("14.0")
    ],
    products: [
        .library(name: "emarsys-sdk", targets: ["emarsys_sdk"])
    ],
    dependencies: [
        // Keep in sync with the EmarsysSDK dependency in ../emarsys_sdk.podspec.
        .package(url: "https://github.com/emartech/ios-emarsys-sdk", .upToNextMinor(from: "3.10.2"))
    ],
    targets: [
        .target(
            name: "emarsys_sdk",
            dependencies: [
                .product(name: "EmarsysSDKLibrary", package: "ios-emarsys-sdk")
            ]
        )
    ]
)
