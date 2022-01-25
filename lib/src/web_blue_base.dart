part of '../web_blue.dart';

class Blue extends Delegate<Object> {
  Blue._(delegate) : super(delegate);

  Future<bool> getAvailability() {
    var promise = callMethod('getAvailability');
    return promiseToFuture(promise);
  }
}
