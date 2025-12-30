// Top-level build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // Android Gradle plugin
        classpath("com.android.tools.build:gradle:8.1.1")
        // Kotlin Gradle plugin
        classpath(kotlin("gradle-plugin", version = "1.8.20"))
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: clean task for Kotlin DSL
tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
