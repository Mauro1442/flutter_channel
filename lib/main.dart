import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const methodChannel = MethodChannel('com.example.app/method_channel');
  static const eventChannel = EventChannel("com.example.app/event_channel");
  static const printChannel = BasicMessageChannel("com.example.app/print_channel", StandardMessageCodec());

  String _sensorAvailable = 'Unknown';
  double _sensorValue = 0.0;
  StreamSubscription? _sensorSubscription;

  Future<void> _checkAvailability() async {
    try {
      var available = await methodChannel.invokeMethod("isSensorAvailable");
      setState(() {
        _sensorAvailable = available.toString();
      });
    }  on PlatformException catch (e) {
      print(e.message);
    }
  }

  _startReading() {
    _sensorSubscription = eventChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _sensorValue = event;
      });
    });
  }

  _stopReading() {
    setState(() {
      _sensorValue = 0;
    });
    _sensorSubscription?.cancel();
  }

  _printMessage() async {
    var response = await printChannel.send("connect");
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sensor Available?: $_sensorAvailable'),
            ElevatedButton(
              onPressed: () => _checkAvailability(),
              child: const Text('Check Sensor Availability'),
            ),
            const SizedBox(height: 20),
            if (_sensorValue > 0)
              Text('Event Channel Reading: $_sensorValue'),
            if (_sensorAvailable == 'true' && _sensorValue == 0)
              ElevatedButton(onPressed: _startReading, child: const Text('Start Reading')),
            if (_sensorAvailable == 'true' && _sensorValue > 0)
              ElevatedButton(onPressed: _stopReading, child: const Text('Stop Reading')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _printMessage(),
              child: const Text('Print Message'),
            ),
          ],
        ),
      ),
    );
  }
}
