Dart wrapper via `dart:js` for https://webbluetoothcg.github.io/web-bluetooth/

## Features

- canUseBlue
- getAvailability
- subscribeAvailabilitychanged/unsubscribeAvailabilitychanged
- getDevices/requestDevice
- connect/disconnect
- getPrimaryService/getCharacteristic
- startNotifications/stopNotifications
- subscribeValueChanged/unsubscribeValueChanged
- readValue/writeValueWithResponse

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

### subscribeAvailabilitychanged/unsubscribeAvailabilitychanged

https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/onavailabilitychanged

```dart
final EventListener _handleAvailabilitychanged = allowInterop((Event event) {}
...
blue.subscribeAvailabilitychanged(_handleAvailabilitychanged);
...
blue.unsubscribeAvailabilitychanged(_handleAvailabilitychanged);
```

### getDevices/requestDevice

- https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getDevices

```dart
List<BlueDevice> getDevices = await blue.getDevices();
_device = getDevices[0];
```

- https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice

```dart
BlueDevice requestDevice = await blue.requestDevice(RequestOptions(
  optionalServices: [BlueUUID.getService(WOODEMI_SERV__COMMAND)],
  acceptAllDevices: true,
));
_device = requestDevice;
```

### connect/disconnect

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/connect

```dart
_device?.gatt.connect().then((value) {
  print('device.gatt.connect success');
}).catchError((error) {
  print('device.gatt.connect $error');
});
```

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/disconnect

```dart
_device?.gatt.disconnect();
```

### getPrimaryService/getCharacteristic

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTServer/getPrimaryService

```dart
_service = await _device!.gatt.getPrimaryService(BlueUUID.getService(WOODEMI_SERV__COMMAND));
```

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTService/getCharacteristic

```dart
_characteristic = await _service!.getCharacteristic(BlueUUID.getCharacteristic(WOODEMI_CHAR__COMMAND_REQUEST));
```

### startNotifications/stopNotifications

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/startNotifications

```dart
await _characteristic!.startNotifications();
```

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/stopNotifications

```dart
await _characteristic!.stopNotifications();
```

### subscribeValueChanged/unsubscribeValueChanged

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/characteristicvaluechanged

```dart
final EventListener _handleValueChanged = allowInterop((event) {}
...
_characteristic!.subscribeValueChanged(_handleValueChanged);
...
_characteristic!.unsubscribeValueChanged(_handleValueChanged);
```

### readValue/writeValueWithResponse

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/readValue

```dart
var byteData = await _characteristic!.readValue();
```

- https://developer.mozilla.org/en-US/docs/Web/API/BluetoothRemoteGATTCharacteristic/writeValueWithResponse

```dart
_characteristic!.writeValueWithResponse(Uint8List.fromList([0x01, 0x0A, 0x00, 0x00, 0x00, 0x01]));
```

## Additional information

Status in Chromium: https://chromestatus.com/feature/5264933985976320
