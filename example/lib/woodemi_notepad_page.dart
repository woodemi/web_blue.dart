// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:web_blue/web_blue.dart';

const WOODEMI_SUFFIX = 'ba5e-f4ee-5ca1-eb1e5e4b1ce0';

const WOODEMI_SERV__COMMAND = '57444d01-$WOODEMI_SUFFIX';

class WoodemiNotepadPage extends StatefulWidget {
  const WoodemiNotepadPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WoodemiNotepadPageState();
}

class _WoodemiNotepadPageState extends State<WoodemiNotepadPage> {
  BlueDevice? _device;

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
}
