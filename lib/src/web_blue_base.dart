part of '../web_blue.dart';

class Blue extends InteropWrapper<_Blue> {
  final _Blue _interop;

  Blue._(this._interop);

  Future<bool> getAvailability() {
    var promise = _interop.getAvailability();
    return promiseToFuture(promise);
  }

  // FIXME allowInterop
  void subscribeAvailabilitychanged(EventListener listener) {
    _interop.addEventListener('availabilitychanged', listener);
  }

  // FIXME allowInterop
  void unsubscribeAvailabilitychanged(EventListener listener) {
    _interop.removeEventListener('availabilitychanged', listener);
  }

  Future<BlueDevice> requestDevice([RequestOptions? options]) {
    var promise = _interop.requestDevice(options);
    return promiseToFuture(promise).then((value) => BlueDevice._(value));
  }

  Future<List<BlueDevice>> getDevices() {
    var promise = _interop.getDevices();
    return promiseToFuture(promise).then((value) {
      return (value as List).map((e) => BlueDevice._(e)).toList();
    });
  }
}

@JS('Bluetooth')
class _Blue implements Interop {
  /// https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getAvailability
  external Object getAvailability();

  /// https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/requestDevice
  external Object requestDevice(Object? options);

  /// https://developer.mozilla.org/en-US/docs/Web/API/Bluetooth/getDevices
  external Object getDevices();

  /// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
  external void addEventListener(String type, EventListener? listener, [bool? useCapture]);

  /// https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener
  external void removeEventListener(String type, EventListener? listener, [bool? useCapture]);
}

@JS()
@anonymous
class RequestOptions {
  external factory RequestOptions({
    List<RequestOptionsFilter>? filters,
    List<Object>? optionalServices,
    bool? acceptAllDevices,
  });
}

@JS()
@anonymous
class RequestOptionsFilter {
  external factory RequestOptionsFilter({
    List<Object>? services,
  });
}

@JS('BluetoothUUID.getService')
external Object _getService(String name);

@JS('BluetoothUUID.getCharacteristic')
external Object _getCharacteristic(String name);

class BlueUUID {
  BlueUUID._();

  static Object getService(String name) => _getService(name);

  static Object getCharacteristic(String name) => _getCharacteristic(name);
}

class BlueDevice extends Delegate<Object> {
  final BlueRemoteGATTServer gatt;

  BlueDevice._(Object delegate)
      : gatt = BlueRemoteGATTServer._(getProperty(delegate, 'gatt')),
        super(delegate);
}

class BlueRemoteGATTServer extends Delegate<Object> {
  BlueRemoteGATTServer._(Object delegate) : super(delegate);

  Future<BlueRemoteGATTServer> connect() {
    var promise = callMethod('connect');
    return promiseToFuture(promise).then((_) => this);
  }

  void disconnect() => callMethod('disconnect');

  Future<BlueRemoteGATTService> getPrimaryService(Object bluetoothUuid) {
    var promise = callMethod('getPrimaryService', [bluetoothUuid]);
    return promiseToFuture(promise).then((result) => BlueRemoteGATTService._(result));
  }
}

class BlueRemoteGATTService extends Delegate<Object> {
  BlueRemoteGATTService._(Object delegate) : super(delegate);

  Future<BlueRemoteGATTCharacteristic> getCharacteristic(Object bluetoothUuid) {
    var promise = callMethod('getCharacteristic', [bluetoothUuid]);
    return promiseToFuture(promise).then((result) => BlueRemoteGATTCharacteristic(result));
  }
}

class BlueRemoteGATTCharacteristic extends Delegate<EventTarget> {
  BlueRemoteGATTCharacteristic(EventTarget delegate) : super(delegate);

  String get uuid => getPropertyT('uuid');

  ByteData get value => getPropertyT('value');

  Future<BlueRemoteGATTCharacteristic> startNotifications() {
    var promise = callMethod('startNotifications');
    return promiseToFuture(promise).then((_) => this);
  }

  Future<BlueRemoteGATTCharacteristic> stopNotifications() {
    var promise = callMethod('stopNotifications');
    return promiseToFuture(promise).then((_) => this);
  }

  // FIXME allowInterop
  void subscribeValueChanged(EventListener listener) {
    delegate.addEventListener('characteristicvaluechanged', listener);
  }

  // FIXME allowInterop
  void unsubscribeValueChanged(EventListener listener) {
    delegate.removeEventListener('characteristicvaluechanged', listener);
  }

  Future<ByteData> readValue() {
    var promise = callMethod('readValue');
    return promiseToFuture(promise);
  }

  Future<void> writeValueWithResponse(TypedData bytes) {
    var promise = callMethod('writeValueWithResponse', [bytes]);
    return promiseToFuture(promise);
  }

  Future<void> writeValueWithoutResponse(TypedData bytes) {
    var promise = callMethod('writeValueWithoutResponse', [bytes]);
    return promiseToFuture(promise);
  }
}