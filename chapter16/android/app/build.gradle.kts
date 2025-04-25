plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.chapter16"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.chapter16"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

//subprojects {
//    afterEvaluate { project ->
//        // android가 있는 모듈에만 적용
//        project.extensions.findByName("android")?.let { ext ->
//            // ext를 AndroidExtension으로 캐스팅
//            (ext as? com.android.build.gradle.BaseExtension)?.let { androidExt ->
//                // namespace가 null일 경우, group 값을 namespace로 설정
//                if (androidExt.namespace == null) {
//                    androidExt.namespace = project.group.toString()
//                }
//            }
//        }
//    }
//}

flutter {
    source = "../.."
}
