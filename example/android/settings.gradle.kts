pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        gradlePluginPortal()
        mavenCentral()
        maven("https://maven.pkg.jetbrains.space/public/p/compose/dev")
        maven("https://developer.huawei.com/repo/")
    }
    resolutionStrategy {
        eachPlugin {
            if (requested.id.namespace == "com.huawei") {
                if (requested.id.id == "com.huawei.agconnect") {
                    useModule("com.huawei.agconnect:agcp:${requested.version}")
                }
            }
        }
    }
}

dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven("https://maven.pkg.jetbrains.space/public/p/compose/dev")
        maven("https://developer.huawei.com/repo/")
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.9.0" apply false
    id("org.jetbrains.kotlin.android") version "2.1.10" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
    id("com.huawei.agconnect") version "1.9.1.304" apply false
    id("org.gradle.toolchains.foojay-resolver-convention") version ("0.5.0")

}

include(":app")
