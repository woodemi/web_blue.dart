// ignore_for_file: avoid_print, avoid_web_libraries_in_flutter

import 'dart:html' show Event, EventListener;
import 'dart:js' show allowInterop;
import 'dart:js_util' show getProperty;

import 'package:flutter/material.dart';
import 'package:web_blue/web_blue.dart';

import 'woodemi_notepad_page.dart';

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
              child: const Text('subscribeAvailabilitychanged'),
              onPressed: () async {
                blue.subscribeAvailabilitychanged(_handleAvailabilitychanged);
                print('subscribeAvailabilitychanged success');
              },
            ),
            ElevatedButton(
              child: const Text('unsubscribeAvailabilitychanged'),
              onPressed: () async {
                blue.unsubscribeAvailabilitychanged(_handleAvailabilitychanged);
                print('unsubscribeAvailabilitychanged success');
              },
            ),
            ElevatedButton(
              child: const Text('Woodemi Notepad'),
              onPressed: () {
                var route = MaterialPageRoute(builder: (context) {
                  return const WoodemiNotepadPage();
                });
                Navigator.of(context).push(route);
              },
            ),
          ],
        ),
      ),
    );
  }
}

final EventListener _handleAvailabilitychanged = allowInterop((Event event) {
  print('_handleAvailabilitychanged $event');
  bool available = getProperty(event, 'value');
  print('available $available');
});
