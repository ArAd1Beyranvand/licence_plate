pluginManagement {
    repositories { gradlePluginPortal(); mavenCentral() }
}
dependencyResolutionManagement {
    // mavenLocal first, so a plate_core published from the checkout beside this one is the one used.
    repositories { mavenLocal(); mavenCentral() }
}

rootProject.name = "license_plate"
