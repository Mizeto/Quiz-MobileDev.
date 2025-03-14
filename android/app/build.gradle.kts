dependencies {
  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:33.10.0"))


  // TODO: Add the dependencies for Firebase products you want to use
  // When using the BoM, don't specify versions in Firebase dependencies
  // https://firebase.google.com/docs/android/setup#available-libraries
}

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.quiz"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    compileSdkVersion(34)
    defaultConfig {
        applicationId = "com.example.quiz"
        minSdkVersion(23) // ใช้ฟังก์ชัน
        targetSdkVersion(30) // ใช้ฟังก์ชัน

        // ใช้ if แทน ?: สำหรับการตรวจสอบและตั้งค่า versionCode และ versionName
        versionCode = if (project.hasProperty("flutterVersionCode")) {
            project.property("flutterVersionCode").toString().toInt()
        } else {
            1
        }

        versionName = if (project.hasProperty("flutterVersionName")) {
            project.property("flutterVersionName").toString()
        } else {
            "1.0.0"
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    ndkVersion = "27.0.12077973"
}

flutter {
    source = "../.."
}
