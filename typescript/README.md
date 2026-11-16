# license_plate (TypeScript)

Every licence plate in one package: **182 countries and territories** behind a single dependency, for [`plate_core`](https://github.com/ArAd1Beyranvand/licence_plate).

## Install

```sh
npm install license_plate plate_core
```

## Use

```ts
import { iran, COUNTRIES } from 'license_plate';
// or one country only, tree-shaken: import iran from 'license_plate/iran';

console.log(COUNTRIES.length, 'countries;', iran.types.length, 'Iranian plate types');
```

Each country is also published on its own as `<country>_plate`; pick this package when you want them all.
Flags and stickers ship under `packages/<country>_plate/assets/`, where plate_core's default asset resolver looks.

Same plates for Flutter: [`license_plate` on pub.dev](https://pub.dev/packages/license_plate).
