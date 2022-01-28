// ignore_for_file: avoid_print, avoid_web_libraries_in_flutter

import 'dart:html' show EventListener;
import 'dart:js' show allowInterop;

import 'package:flutter/material.dart';
import 'package:web_blue/web_blue.dart';

const WOODEMI_SUFFIX = 'ba5e-f4ee-5ca1-eb1e5e4b1ce0';

const WOODEMI_SERV__COMMAND = '57444d01-$WOODEMI_SUFFIX';
const WOODEMI_CHAR__COMMAND_REQUEST = '57444e02-$WOODEMI_SUFFIX';
const WOODEMI_CHAR__COMMAND_RESPONSE = WOODEMI_CHAR__COMMAND_REQUEST;

class WoodemiNotepadPage extends StatefulWidget {
  const WoodemiNotepadPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WoodemiNotepadPageState();
}

class _WoodemiNotepadPageState extends State<WoodemiNotepadPage> {
  BlueDevice? _device;
  BlueRemoteGATTService? _service;
  BlueRemoteGATTCharacteristic? _characteristic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woodemi Notepad'),
      ),
      body: Center(
        child: Column(
          children: [
            _buildRequestGet(),
            _buildConnectDisconnect(),
            _buildServiceCharacteristic(),
            _buildStartStopNotifications(),
            _buildValueChangedSubscription(),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestGet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('requestDevice'),
          onPressed: () async {
            BlueDevice requestDevice = await blue.requestDevice(RequestOptions(
              optionalServices: [BlueUUID.getService(WOODEMI_SERV__COMMAND)],
              acceptAllDevices: true,
            ));
            print('requestDevice $requestDevice');
            _device = requestDevice;
          },
        ),
        ElevatedButton(
          child: const Text('getDevices'),
          onPressed: () async {
            List<BlueDevice> getDevices = await blue.getDevices();
            print('getDevices $getDevices');
            _device = getDevices[0];
          },
        ),
      ],
    );
  }

  Widget _buildConnectDisconnect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('device.gatt.connect'),
          onPressed: () {
            _device?.gatt.connect().then((value) {
              print('device.gatt.connect success');
            }).catchError((error) {
              print('device.gatt.connect $error');
            });
          },
        ),
        ElevatedButton(
          child: const Text('device.gatt.disconnect'),
          onPressed: () async {
            _device?.gatt.disconnect();
            print('device.gatt.disconnect success');
          },
        ),
      ],
    );
  }

  Widget _buildServiceCharacteristic() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('device.getPrimaryService'),
          onPressed: () async {
            _service = await _device!.gatt.getPrimaryService(BlueUUID.getService(WOODEMI_SERV__COMMAND));
            print('service $_service');
          },
        ),
        ElevatedButton(
          child: const Text('service.getCharacteristic'),
          onPressed: () async {
            _characteristic = await _service!.getCharacteristic(BlueUUID.getCharacteristic(WOODEMI_CHAR__COMMAND_REQUEST));
            print('characteristic $_characteristic');
          },
        ),
      ],
    );
  }


  Widget _buildStartStopNotifications() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('characteristic.startNotifications'),
          onPressed: () async {
            await _characteristic!.startNotifications();
            print('characteristic.startNotifications success');
          },
        ),
        ElevatedButton(
          child: const Text('characteristic.stopNotifications'),
          onPressed: () async {
            await _characteristic!.stopNotifications();
            print('characteristic.stopNotifications success');
          },
        ),
      ],
    );
  }

  Widget _buildValueChangedSubscription() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('characteristic.subscribeValueChanged'),
          onPressed: () {
            _characteristic!.subscribeValueChanged(_handleValueChanged);
            print('characteristic.subscribeValueChanged success');
          },
        ),
        ElevatedButton(
          child: const Text('characteristic.unsubscribeValueChanged'),
          onPressed: () {
            _characteristic!.unsubscribeValueChanged(_handleValueChanged);
            print('characteristic.unsubscribeValueChanged success');
          },
        ),
      ],
    );
  }
}

final EventListener _handleValueChanged = allowInterop((event) {
  var characteristic = BlueRemoteGATTCharacteristic(event.target!);
  print('_handleValueChanged ${characteristic.uuid}, ${characteristic.value}');
});
