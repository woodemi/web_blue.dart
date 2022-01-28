// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:web_blue/web_blue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('web_blue example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('canUse'),
              onPressed: () {
                bool canUse = canUseBlue();
                print('canUse $canUse');
              },
            ),
            ElevatedButton(
              child: const Text('getAvailability'),
              onPressed: () async {
                bool availability = await blue.getAvailability();
                print('availability $availability');
              },
            ),
            ElevatedButton(
              child: const Text('BlueUUID.getService'),
              onPressed: () async {
                BlueUUID.getService('device_information');
              },
            ),
          ],
        ),
      ),
    );
  }
}
