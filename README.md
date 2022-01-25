Dart wrapper via `dart:js` for https://webbluetoothcg.github.io/web-bluetooth/

## Features

- canUseBlue
- getAvailability

## Usage

### canUseBlue

```dart
bool canUse = canUseBlue();
print('canUse $canUse');
```

### getAvailability

https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getAvailability

```dart
bool availability = await blue.getAvailability();
print('availability $availability');
```

## Additional information

Status in Chromium: https://chromestatus.com/feature/5264933985976320
