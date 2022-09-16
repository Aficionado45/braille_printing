import 'package:braille_printing/views/pdf.dart';
import 'package:braille_printing/views/voice.dart';
import 'package:flutter/material.dart';
import 'package:braille_printing/views/welcome.dart';
import 'views/ocr.dart';
import 'package:braille_printing/views/bluetooth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Braille App',
      initialRoute: 'welcome',
      routes: {
        'welcome': (context) => WelcomeScreen(),
        'ocr': (context) => OcrCapture(),
        'bluetooth': (context) => Bluetooth(),
        'pdf': (context) => PdfRead(),
        'voice': (context) => VoiceText(),
      },
    );
  }
}
