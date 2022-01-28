part of '../web_blue.dart';

class Blue extends Delegate<EventTarget> {
  Blue._(EventTarget delegate) : super(delegate);

  Future<bool> getAvailability() {
    var promise = callMethod('getAvailability');
    return promiseToFuture(promise);
  }

  // FIXME allowInterop
  void subscribeAvailabilitychanged(EventListener listener) {
    delegate.addEventListener('availabilitychanged', listener);
  }

  // FIXME allowInterop
  void unsubscribeAvailabilitychanged(EventListener listener) {
    delegate.removeEventListener('availabilitychanged', listener);
  }

  Future<BlueDevice> requestDevice([RequestOptions? options]) {
    var promise = callMethod('requestDevice', [
      if (options != null) options,
    ]);
    return promiseToFuture(promise).then((value) => BlueDevice._(value));
  }

  Future<List<BlueDevice>> getDevices() {
    var promise = callMethod('getDevices');
    return promiseToFuture(promise).then((value) {
      return (value as List).map((e) => BlueDevice._(e)).toList();
    });
  }
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
    return promiseToFuture(promise).then((result) => BlueRemoteGATTCharacteristic._(result));
  }
}

class BlueRemoteGATTCharacteristic extends Delegate<EventTarget> {
  BlueRemoteGATTCharacteristic._(EventTarget delegate) : super(delegate);
}