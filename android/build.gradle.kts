buildscript {
    val kotlinVersion by extra("1.9.0") // or compatible version
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.11.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
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
