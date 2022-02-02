@JS()
library web_blue;

import 'dart:html' show EventListener, EventTarget;
import 'dart:js_util' show getProperty, promiseToFuture;
import 'dart:typed_data';

import 'package:js/js.dart';

import 'src/js_facade.dart';

part 'src/web_blue_base.dart';

@JS('navigator.bluetooth')
external _Blue? get _blue;

bool canUseBlue() => _blue != null;

Blue? _instance;
Blue get blue {
  if (_blue != null) {
    return _instance ??= Blue._(_blue!);
  }
  throw 'navigator.bluetooth unavailable';
}
