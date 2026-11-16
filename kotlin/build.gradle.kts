import org.jetbrains.kotlin.gradle.ExperimentalWasmDsl
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    kotlin("multiplatform") version "2.2.20"
    id("com.vanniktech.maven.publish") version "0.34.0"
}

group = "io.github.arad1beyranvand"
version = "0.1.0"

kotlin {
    jvmToolchain(21)
    jvm { compilerOptions { jvmTarget.set(JvmTarget.JVM_11); freeCompilerArgs.add("-Xjdk-release=11") } }
    js(IR) { browser() }
    @OptIn(ExperimentalWasmDsl::class)
    wasmJs { browser() }

    sourceSets {
        commonMain {
            // packages/<country>_plate/assets/..., where plate_core's default resolver looks.
            resources.srcDir("assets")
            dependencies { api("io.github.arad1beyranvand:plate_core:0.1.0") }
        }
    }
}

mavenPublishing {
    publishToMavenCentral(automaticRelease = true)
    if (providers.gradleProperty("signingInMemoryKey").isPresent || providers.gradleProperty("signing.keyId").isPresent) signAllPublications()
    coordinates("io.github.arad1beyranvand", "license_plate", "0.1.0")
    pom {
        name.set("license_plate")
        description.set("Licence plates of 182 countries in one package, for plate_core.")
        url.set("https://github.com/ArAd1Beyranvand/licence_plate")
        licenses { license { name.set("MIT License"); url.set("https://opensource.org/licenses/MIT") } }
        developers { developer { id.set("arad1beyranvand"); name.set("ArAd Beyranvand") } }
        scm { url.set("https://github.com/ArAd1Beyranvand/licence_plate"); connection.set("scm:git:https://github.com/ArAd1Beyranvand/licence_plate.git") }
    }
}
