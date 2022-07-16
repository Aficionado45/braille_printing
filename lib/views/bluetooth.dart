import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:braille_printing/views/connection.dart';
import 'package:braille_printing/views/servo.dart';

class Bluetooth extends StatelessWidget {
  final String scannedText;
  Bluetooth({Key key, @required this.scannedText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Servo',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          } else if (future.connectionState == ConnectionState.done) {
            return Home(
              scannedText: scannedText,
            );
          } else {
            return Home(
              scannedText: scannedText,
            );
          }
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  final String scannedText;
  Home({Key key, @required this.scannedText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Braille Bluetooth",
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width / 4,
        leading: Padding(
          padding: const EdgeInsets.all(0),
          child: Hero(
            tag: 'logo',
            child: Image(
              image: AssetImage('images/braille.jpg'),
            ),
          ),
        ),
      ),
      body: SelectBondedDevicePage(
        onCahtPage: (device1) {
          BluetoothDevice device = device1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatPage(
                  server: device,
                  scannedText: scannedText,
                );
              },
            ),
          );
        },
      ),
    ));
  }
}
