import java.util.Properties
import java.io.FileInputStream

plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.olav.grambix"
    compileSdk = 34
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11
    }

    defaultConfig {
        applicationId = "com.olav.grambix"
        minSdk = 21
        targetSdk = 34
        versionCode = 2
        versionName = "1.2.0"
        multiDexEnabled = true
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
                    minifyEnabled false
        }
        debug {
            signingConfig signingConfigs.release
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation 'com.android.billingclient:billing:6.0.1'
}