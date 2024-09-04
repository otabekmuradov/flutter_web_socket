import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(const FlutterWebSocket());
}

class FlutterWebSocket extends StatefulWidget {
  const FlutterWebSocket({super.key});

  @override
  State<FlutterWebSocket> createState() => _FlutterWebSocketState();
}

class _FlutterWebSocketState extends State<FlutterWebSocket> {
  final channel = IOWebSocketChannel.connect('wss://stream.binance.com:9443/ws/btcusdt@trade');
  String btcPrice = "0";

  streamListener() {
    channel.stream.listen((message) {
      // channel.sink.add('RECEIVED');
      Map getData = jsonDecode(message);
      setState(() {
        btcPrice = getData['p'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    streamListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BTC/USDT Price : ',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                btcPrice,
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
