# license_plate (Kotlin)

Every licence plate in one package: **182 countries and territories** behind a single dependency, for [`plate_core`](https://github.com/ArAd1Beyranvand/licence_plate).

## Install

```kotlin
commonMain.dependencies { implementation("io.github.arad1beyranvand:license_plate:0.1.0") }
```

## Use

```kotlin
import plates.countries.iran.Iran

println("${Iran.types.size} Iranian plate types")
```

Each country is also published on its own as `<country>_plate`; pick this package when you want them all.
Flags and stickers ship under `packages/<country>_plate/assets/`, where plate_core's default asset resolver looks.

Same plates for Flutter: [`license_plate` on pub.dev](https://pub.dev/packages/license_plate).
